import os
import json

import yaml
from clickhouse_driver import Client
import sqlalchemy


def updateAppData(engine, d):
    with engine.connect() as con:
        try:
            sql = '''
            UPDATE public.app_data
            SET
            "details" = :details,
            "updated_on" = now()
            WHERE data_key = :data_key
            RETURNING data_uuid
            '''
            statement = sqlalchemy.sql.text(sql)
            row = con.execute(statement, **d)
            return {'ok': True, 'row': row.fetchone()}
        except Exception as e:
            print('updateAppData error: ', e)
            return {'ok': False, 'error': e}


def getChClient():
    client = Client(
        'lua-2.luabase.altinity.cloud',
        user='admin',
        password=os.getenv('CH_ADMIN_PASSWORD'),
        port=9440,
        secure=True,
        verify=False,
        database='default',
        compression=True,
        settings={'use_numpy': True}
    )
    return client


if __name__ == '__main__':

    supaRaw = sqlalchemy.create_engine(os.getenv('SUPABASE_SQLALCHEMY_DATABASE_URI'))
    rawTest = supaRaw.execute('select 1')
    print('rawTest: ', rawTest)

    client = getChClient()

    sql = '''
    select
    `database`,
    `table`,
    `name`,
    `type`,
    `position`,
    `default_kind`,
    `default_expression`,
    `is_in_partition_key`,
    `is_in_sorting_key`,
    `is_in_primary_key`,
    `is_in_sampling_key`,
    `numeric_precision`,
    `numeric_precision_radix`,
    `numeric_scale`,
    `datetime_precision`,
    `comment`
    from system.columns
    where `database` in (
        'prices',
        'ethereum',
        'polygon',
        'bitcoin'
        )
    order by `database`, `table`, `position`;
    '''
    df = client.query_dataframe(sql)
    print(df.head())

    # dbs = ['ethereum', 'bitcoin', 'prices'] # add solana, polygon, terra, etc.
    print('all dbs:', df.database.unique())
    schema = {'dbs': {}}
    for db in df.database.unique():
        print(f'doing db: {db}')
        with open(f'models/{db}/schema.yml', 'r') as stream:
            try:
                y = yaml.safe_load(stream)
                chCols = df[df.database == db].to_dict(orient='records')
                for model in y['models']:
                    for chCol in chCols:
                        if (chCol['table'] == model['name']) or (chCol['table'] == model.get('config', {}).get('alias', '')):
                            for yCol in model['columns']:
                                if yCol['name'] == chCol['name'] or yCol.get('config', {}).get('alias', '') == chCol['name']:
                                    yCol['ch'] = chCol
                                    break
                schema['dbs'][db] = y['models']
            except yaml.YAMLError as e:
                print(e)

    print('done clickhouse pull...')

    print(f'updating postgres... {json.dumps(schema)}')
    updateAppData(supaRaw, {
        'data_key': 'schema',
        'details': json.dumps(schema)
    })

    print('done updating postgres...')

    print('done.')
