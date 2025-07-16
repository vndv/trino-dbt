SELECT * FROM {{ source('remote_gp', 'orders') }}
