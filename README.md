# finaktiva-technical-test
Prueba tecnica Julian Morantes

# 🚀 Proyecto de Infraestructura y Despliegue con Terraform y GitHub Actions

Este proyecto implementa una infraestructura modular usando **Terraform** sobre AWS, automatizada con **GitHub Actions** para desplegar aplicaciones en diferentes entornos (`dev`, `stg`, `prod`) y regiones específicas. 

---

## 📁 Estructura de Carpetas

```text
📦 Proyecto
├── 📁 .github
│   └── 📁 workflows
│       ├── deploy.yaml        # Despliegue automatizado con GitHub Actions
│       └── destroy.yaml       # Destrucción opcional de infraestructura
│
├── 📁 iac                     # Infraestructura como código con Terraform
│   ├── main.tf                # Archivo principal
│   ├── variables.tf           # Variables globales
│   ├── outputs.tf             # Salidas de interés
│   └── 📁 modules
│       ├── 📁 vpc             # Módulo de red VPC
│       ├── 📁 alb             # Módulo del Application Load Balancer
│       ├── 📁 ecs             # Módulo ECS (Fargate)
│       └── 📁 ecr             # Módulo de Amazon ECR
│
├── 📁 environments            # Variables por entorno
│   ├── dev.tfvars             # Variables para entorno dev
│   ├── stg.tfvars             # Variables para entorno stg
│   └── prod.tfvars            # Variables para entorno prod
│
├── 📁 doc                     # Documentación del proyecto
│   └── estrategias.md         # Estrategias de despliegue y decisiones
│
└── README.md                  # Descripción general del proyecto
```

---

## 🧱 Descripción de Carpetas Clave

### `.github/workflows/`
Contiene los workflows de CI/CD:
- `deploy.yaml`: Despliega infraestructura y aplicaciones según el entorno y región.
- `destroy.yaml`: (opcional) Destruye la infraestructura correspondiente.

### `iac/`
Contiene el código de Terraform, modularizado en:
- `modules/vpc`: VPC, subredes y rutas.
- `modules/alb`: Application Load Balancer.
- `modules/ecs`: ECS Services + Fargate.
- `modules/ecr`: Repositorios de imágenes.

### `environments/`
Variables por entorno (`*.tfvars`) con configuraciones específicas de región, subredes y contenedores.

### `doc/`
Documentación técnica y decisiones de arquitectura, incluyendo estrategias de despliegue.

---

## 🚦 Estrategias de Despliegue en ECS

### 1. Rolling Updates
- ✅ Despliegue gradual de nuevas versiones.
- ✅ Alta disponibilidad sin downtime.
- ❌ Puede tardar más en ambientes grandes.

### 2. Blue-Green Deployments
- ✅ Permite pruebas antes del cambio de tráfico.
- ✅ Rollback inmediato si algo falla.
- ❌ Requiere infraestructura duplicada.

---

## ▶️ Ejecución de Pipelines CI/CD

### 🔧 Preparación
Verifica el archivo `.tfvars` para el entorno deseado dentro de `environments/`.

### 🚀 Ejecutar Despliegue
1. Ve a **GitHub → Actions → Terraform Deploy**
2. Selecciona el entorno (`dev`, `stg`, `prod`).
3. Haz clic en **Run workflow**.

### 🔥 Destruir Infraestructura
1. Ve a **GitHub → Actions → Terraform Destroy**
2. Elige el entorno a destruir.
3. Ejecuta el workflow manualmente.

---

## 🤝 Contribuciones

1. Haz un fork del repositorio.
2. Crea una rama con tu cambio.
3. Envía un Pull Request para revisión.

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
