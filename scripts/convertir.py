import json, csv, datetime, os

metricas = {
    "cpu_metrics.json":     "cpu_uso",
    "mem_metrics.json":     "mem_disponible",
    "storage_metrics.json": "storage_libre"
}

# Primero unimos todo en un dict por (timestamp, nodo)
filas = {}

for archivo, columna in metricas.items():
    ruta = f"/data/{archivo}"
    if not os.path.exists(ruta):
        print(f"No encontrado: {ruta}, saltando...")
        continue
    with open(ruta) as f:
        data = json.load(f)
    for result in data["data"]["result"]:
        nodo = result["metric"].get("instance", "desconocido")
        for ts, val in result["values"]:
            clave = (ts, nodo)
            if clave not in filas:
                filas[clave] = {
                    "timestamp": ts,
                    "fecha": datetime.datetime.fromtimestamp(float(ts))
                                .strftime("%Y-%m-%d %H:%M:%S"),
                    "nodo": nodo,
                    "cpu_uso": 0,
                    "mem_disponible": 0,
                    "storage_libre": 0
                }
            filas[clave][columna] = round(float(val), 4)

with open("/data/metricas_cluster.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=[
        "timestamp","fecha","nodo","cpu_uso","mem_disponible","storage_libre"
    ])
    writer.writeheader()
    writer.writerows(filas.values())

print(f"CSV generado con {len(filas)} filas")