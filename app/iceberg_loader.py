from typing import Dict, Generator, List, Literal

import pandas as pd
import pyarrow as pa


class IcebergLoader:
    TABLE_PROPERTIES = {
        "write.format.default": "parquet",
        "write.metadata.compression-codec": "gzip",
        "format-version": "2",
    }

    def _data_converter(self, data: Generator[List[Dict]]):
        df = pd.DataFrame(data)

        return pa.Table.from_pandas(df)

    def load_data_to_iceberg(
        self,
        data: Generator[List[Dict]],
        table_identifier: tuple[str, str],
        catalog,
        write_mode: Literal["overwrite", "append"] = "overwrite",
    ):
        table_data = self._data_converter(data)
        if not catalog.table_exists(table_identifier):
            catalog.create_table(
                identifier=table_identifier,
                schema=table_data.schema,
                properties=self.TABLE_PROPERTIES,
            )
            print(f"Создана таблица {table_identifier[0]}.{table_identifier[1]}")
        table = catalog.load_table(table_identifier)

        if write_mode == "overwrite":
            table.overwrite(table_data)
            print(f"Данные записаны в {table_identifier[0]}.{table_identifier[1]}")
        else:
            table.append(table_data)
            print(f"Данные добавлены в {table_identifier[0]}.{table_identifier[1]}")
