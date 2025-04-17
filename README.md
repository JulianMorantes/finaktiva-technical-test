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

# Ejecución Manual de Terraform
### Requisitos Previos
Antes de ejecutar Terraform desde tu máquina local, asegúrate de tener las siguientes herramientas instaladas:

1. Terraform CLI
Infraestructura como código para aprovisionar recursos en la nube.
Descargar desde: Terraform Downloads
Comando para verificar instalación:

`terraform -v`

2. AWS CLI
Herramienta oficial para autenticación y gestión de recursos en AWS.
Descargar desde: AWS CLI Installation
Comando para verificar instalación:

`aws --version`

3. Configurar credenciales de AWS
Autentícate con tus credenciales de AWS ejecutando el siguiente comando:

`aws configure`

Esto solicitará los siguientes datos:
`AWS Access Key ID`
`AWS Secret Access Key`
`Default region name (ejemplo: us-east-1)`
`Default output format (opcional, ejemplo: json)`

Comandos para Ejecutar Terraform
Sigue los pasos a continuación para ejecutar Terraform manualmente desde tu terminal.

1. Inicializar el proyecto
Desde la carpeta iac/, ejecuta:
`cd iac`
`terraform init`

2. Verificar el plan de despliegue
Genera el plan de despliegue para tu entorno (por ejemplo, dev, stg, prod):

`terraform plan -var-file=../environments/dev.tfvars`
3. Aplicar la infraestructura
Para aplicar los cambios y desplegar la infraestructura:

`terraform apply -var-file=../environments/dev.tfvars`
Se te pedirá confirmar la acción escribiendo "yes".

4. Destruir la infraestructura (opcional)
Si necesitas destruir la infraestructura creada:

`terraform destroy -var-file=../environments/dev.tfvars`
---

## 🤝 Contribuciones

1. Haz un fork del repositorio.
2. Crea una rama con tu cambio.
3. Envía un Pull Request para revisión.

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.


