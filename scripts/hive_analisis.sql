USE cluster_metrics;

-- 1. Media y máximo de CPU por nodo
SELECT nodo,
       ROUND(AVG(cpu_uso), 2) AS media_cpu,
       ROUND(MAX(cpu_uso), 2) AS max_cpu,
       ROUND(MIN(cpu_uso), 2) AS min_cpu
FROM metricas_cluster
GROUP BY nodo
ORDER BY media_cpu DESC;

-- 2. Nodos más cargados
SELECT nodo,
       ROUND(AVG(cpu_uso), 2) AS media_cpu
FROM metricas_cluster
GROUP BY nodo
ORDER BY media_cpu DESC
LIMIT 3;

-- 3. Crecimiento almacenamiento por día
SELECT fecha,
       nodo,
       ROUND(AVG(storage_libre)/1073741824, 2) AS gb_libres
FROM metricas_cluster
GROUP BY fecha, nodo
ORDER BY fecha ASC;