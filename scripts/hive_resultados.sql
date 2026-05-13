USE cluster_metrics;

CREATE TABLE IF NOT EXISTS resultados_analisis AS
SELECT
    fecha,
    nodo,
    ROUND(AVG(cpu_uso), 2)         AS media_cpu,
    ROUND(MAX(cpu_uso), 2)         AS max_cpu,
    ROUND(AVG(mem_disponible), 2)  AS media_mem,
    ROUND(AVG(storage_libre), 2)   AS media_storage
FROM metricas_cluster
GROUP BY fecha, nodo
ORDER BY fecha, nodo;

SELECT * FROM resultados_analisis;