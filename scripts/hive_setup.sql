CREATE DATABASE IF NOT EXISTS cluster_metrics;
USE cluster_metrics;

CREATE TABLE IF NOT EXISTS metricas_cluster (
    ts      BIGINT,
    fecha          STRING,
    nodo           STRING,
    cpu_uso        DOUBLE,
    mem_disponible DOUBLE,
    storage_libre  DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
TBLPROPERTIES ('skip.header.line.count'='1');

LOAD DATA INPATH '/user/hive/metrics/metricas_cluster.csv'
INTO TABLE metricas_cluster;

SELECT COUNT(*) FROM metricas_cluster;