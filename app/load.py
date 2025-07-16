from catalog import get_catalog
from iceberg_loader import IcebergLoader
from rest_adapter import RestAdapter

loader = IcebergLoader()
catalog = get_catalog()
adapter = RestAdapter()

endpoint_list = ["customers", "orders", "items", "products", "supplies", "stores"]

for endpoint in endpoint_list:
    endpoint_data = adapter.get_data(endpoint)

    loader.load_data_to_iceberg(
        data=endpoint_data, table_identifier=("api_data", endpoint), catalog=catalog
    )
