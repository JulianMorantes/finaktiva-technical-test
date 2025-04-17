# finaktiva-technical-test
Prueba tecnica Julian Morantes

## 📁 Estructura del Proyecto

```text
📦 Proyecto
├── 📁 .github
│   └── 📁 workflows
│       ├── deploy.yaml        # Despliegue automatizado con GitHub Actions
│       └── destroy.yaml       # (Opcional) Destrucción de infraestructura
│
├── 📁 iac                     # Infraestructura como código con Terraform
│   ├── main.tf                # Archivo principal
│   ├── variables.tf           # Variables globales
│   ├── outputs.tf             # Salidas útiles
│   └── 📁 modules
│       ├── 📁 vpc             # Módulo de red VPC
│       ├── 📁 alb             # Módulo del Application Load Balancer
│       ├── 📁 ecs             # Módulo de ECS (Fargate)
│       └── 📁 ecr             # Módulo de Amazon ECR
│
├── 📁 environments            # Variables por entorno
│   ├── dev.tfvars             # Variables para ambiente dev
│   ├── stg.tfvars             # Variables para ambiente stg
│   └── prod.tfvars            # Variables para ambiente prod
│
├── 📁 doc                     # Documentación del proyecto
│   └── estrategias.md         # Estrategias de despliegue usadas (rolling, blue/green)
│
└── README.md                  # Descripción del proyecto y guía de uso

# Proyecto de Infraestructura y Despliegue con Terraform y GitHub Actions

Este proyecto implementa una infraestructura modular usando **Terraform** en AWS, automatizada mediante **GitHub Actions** para el despliegue de aplicaciones en diferentes entornos (dev, stg, prod) y regiones.

## Estructura de Carpetas

El proyecto está organizado en las siguientes carpetas principales:

### 1. `.github/`
Contiene los archivos relacionados con los **workflows de GitHub Actions** para automatizar la ejecución de los pipelines de CI/CD.

- **`/workflows`**: Contiene los flujos de trabajo para ejecutar las diferentes fases de CI/CD. Estos workflows definen el ciclo de vida del despliegue de infraestructura y aplicaciones usando Terraform.
    - **`deploy.yaml`**: Workflow para desplegar la infraestructura de AWS utilizando Terraform. Permite la implementación en diferentes entornos (dev, stg, prod).
    - **`destroy.yaml`**: (Opcional) Workflow para destruir la infraestructura cuando ya no es necesaria, eliminando recursos en AWS.

### 2. `iac/`
Contiene todos los archivos de **infraestructura como código** usando **Terraform**. 

- **`/modules`**: Aquí están los módulos reutilizables de Terraform para desplegar recursos en AWS, como VPC, ECS, ALB, entre otros.
    - **`/vpc`**: Define la configuración de la VPC, subredes y otras configuraciones relacionadas con la red.
    - **`/ecs`**: Contiene la definición de los servicios de ECS para las aplicaciones (contenedores) que se ejecutan en Fargate.
    - **`/alb`**: Configura el Application Load Balancer (ALB) para acceder a las aplicaciones de forma segura.
    - **`/ecr`**: Define los recursos de Amazon ECR (Elastic Container Registry) para almacenar imágenes Docker.
  
- **`main.tf`**: Archivo principal donde se configura la infraestructura general, integrando los módulos y haciendo uso de las variables de entorno.
- **`variables.tf`**: Declara todas las variables utilizadas en los módulos y configuraciones de Terraform.
- **`outputs.tf`**: Contiene las salidas relevantes, como la URL del ALB.

### 3. `environments/`
Contiene archivos `.tfvars` para definir las variables específicas de cada entorno. Esto permite la reutilización de la misma infraestructura en diferentes regiones o configuraciones, solo cambiando los valores de las variables.

- **`dev.tfvars`**: Variables específicas para el entorno de desarrollo (ej. configuraciones de subredes, VPC, imágenes de contenedores, etc.).
- **`stg.tfvars`**: Variables específicas para el entorno de staging.
- **`prod.tfvars`**: Variables específicas para el entorno de producción.

### 4. `doc/`
En esta carpeta se documentan todas las **estrategias utilizadas** para la implementación de la infraestructura y el despliegue de aplicaciones. Aquí se detallan las decisiones de diseño, las mejores prácticas y los flujos de trabajo.

- **`estrategias.md`**: Documento que explica las estrategias de despliegue y los beneficios de las mismas, tales como:
    - Estrategias de despliegue de contenedores en ECS (e.g., Rolling Updates, Blue-Green Deployments).
    - Beneficios y desventajas de las distintas configuraciones de red, subredes públicas y privadas, y seguridad.

## Estrategias de Despliegue

Las aplicaciones están desplegadas usando **Amazon ECS con Fargate** y gestionadas mediante Terraform. Se utilizan diferentes estrategias de despliegue para asegurar alta disponibilidad y una correcta gestión del tráfico:

### 1. **Rolling Updates**
   - **Descripción**: Esta estrategia garantiza que las nuevas versiones de la aplicación se desplieguen de manera gradual, reemplazando progresivamente las instancias de tareas antiguas con las nuevas, sin afectar a los usuarios finales.
   - **Beneficios**:
     - Mínimo tiempo de inactividad.
     - Control total sobre la velocidad de despliegue.
   - **Desventajas**:
     - Puede requerir más tiempo para completar el despliegue si las tareas son muchas.

### 2. **Blue-Green Deployments**
   - **Descripción**: Esta estrategia implica la creación de dos entornos (Blue y Green). El tráfico se dirige a uno de los entornos (por ejemplo, Blue), y cuando una nueva versión está lista, se realiza un cambio al entorno Green.
   - **Beneficios**:
     - Despliegue rápido sin impacto en los usuarios.
     - Fácil reversión en caso de problemas.
   - **Desventajas**:
     - Requiere recursos duplicados (Blue y Green).
     - Puede ser costoso debido a la duplicación de recursos.

## ¿Cómo ejecutar el despliegue?

### 1. Preparación
Antes de ejecutar el pipeline de CI/CD, asegúrate de tener configuradas las variables de entorno adecuadas en el archivo `.tfvars` correspondiente a tu entorno (dev, stg, prod).

### 2. Ejecutar el Pipeline

El pipeline se ejecuta automáticamente al hacer push en la rama `main`, pero también puede ser disparado manualmente desde la interfaz de GitHub Actions.

1. Ve a **Actions → Terraform Deploy**.
2. Selecciona el entorno que deseas desplegar (dev, stg, prod).
3. Haz clic en **Run Workflow**.

### 3. Destruir la Infraestructura (opcional)

Si necesitas destruir la infraestructura de un entorno, puedes ejecutar el pipeline de **destroy**.

1. Ve a **Actions → Terraform Destroy**.
2. Selecciona el entorno a destruir.
3. Haz clic en **Run Workflow**.

---

## Contribuir

Si deseas contribuir al proyecto o mejorar alguna parte de la infraestructura, sigue estos pasos:

1. Haz un **fork** del repositorio.
2. Crea una nueva rama para tu cambio.
3. Realiza tus cambios y haz un **commit**.
4. Abre un **pull request** para revisión.

---

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.
