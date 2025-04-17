#!/bin/bash

REGION="us-west-2"
CLUSTER_NAME="demo-cluster"  # cambia si lo nombraste distinto

echo "🚨 Destruyendo entorno 'dev' en región $REGION 🚨"

# 1. Eliminar servicios ECS
echo "🔹 Eliminando servicios ECS..."
SERVICES=$(aws ecs list-services --cluster $CLUSTER_NAME --region $REGION --query 'serviceArns[*]' --output text)
for service in $SERVICES; do
  aws ecs delete-service --cluster $CLUSTER_NAME --service $service --force --region $REGION
done

# 2. Eliminar tareas en ejecución
echo "🔹 Deteniendo tareas ECS..."
TASKS=$(aws ecs list-tasks --cluster $CLUSTER_NAME --region $REGION --query 'taskArns[*]' --output text)
for task in $TASKS; do
  aws ecs stop-task --cluster $CLUSTER_NAME --task $task --region $REGION
done

# 3. Deregistrar definiciones de tareas
echo "🔹 Deregistrando definiciones de tareas..."
TASK_DEFS=$(aws ecs list-task-definitions --region $REGION --query 'taskDefinitionArns[*]' --output text)
for def in $TASK_DEFS; do
  aws ecs deregister-task-definition --task-definition $def --region $REGION
done

# 4. Eliminar cluster ECS
echo "🔹 Eliminando clúster ECS..."
aws ecs delete-cluster --cluster $CLUSTER_NAME --region $REGION

# 5. Eliminar Load Balancers
echo "🔹 Eliminando Load Balancers..."
ALBS=$(aws elbv2 describe-load-balancers --region $REGION --query 'LoadBalancers[*].LoadBalancerArn' --output text)
for alb in $ALBS; do
  aws elbv2 delete-load-balancer --load-balancer-arn $alb --region $REGION
done

# 6. Eliminar Target Groups
echo "🔹 Eliminando Target Groups..."
TGS=$(aws elbv2 describe-target-groups --region $REGION --query 'TargetGroups[*].TargetGroupArn' --output text)
for tg in $TGS; do
  aws elbv2 delete-target-group --target-group-arn $tg --region $REGION
done

# 7. Eliminar Security Groups (solo si no están en uso)
echo "🔹 (Opcional) Eliminando Security Groups..."
SGS=$(aws ec2 describe-security-groups --region $REGION --query 'SecurityGroups[?GroupName!=`default`].GroupId' --output text)
for sg in $SGS; do
  aws ec2 delete-security-group --group-id $sg --region $REGION || echo "No se pudo eliminar $sg (en uso)"
done

# 8. Eliminar subredes (debes confirmar que no estén en uso)
echo "🔹 (Opcional) Eliminando subnets..."
SUBNETS=$(aws ec2 describe-subnets --region $REGION --query 'Subnets[*].SubnetId' --output text)
for subnet in $SUBNETS; do
  aws ec2 delete-subnet --subnet-id $subnet --region $REGION || echo "No se pudo eliminar $subnet (en uso)"
done

# 9. Eliminar IGWs
echo "🔹 (Opcional) Eliminando Internet Gateways..."
IGWS=$(aws ec2 describe-internet-gateways --region $REGION --query 'InternetGateways[*].InternetGatewayId' --output text)
for igw in $IGWS; do
  VPC_ID=$(aws ec2 describe-internet-gateways --internet-gateway-ids $igw --region $REGION --query 'InternetGateways[0].Attachments[0].VpcId' --output text)
  if [ "$VPC_ID" != "None" ]; then
    aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $VPC_ID --region $REGION
  fi
  aws ec2 delete-internet-gateway --internet-gateway-id $igw --region $REGION
done

# 10. Eliminar VPCs (si están vacías)
echo "🔹 (Opcional) Eliminando VPCs vacías..."
VPCS=$(aws ec2 describe-vpcs --region $REGION --query 'Vpcs[*].VpcId' --output text)
for vpc in $VPCS; do
  aws ec2 delete-vpc --vpc-id $vpc --region $REGION || echo "No se pudo eliminar VPC $vpc (en uso)"
done

echo "✅ Destrucción del entorno dev completada (manual en parte)"
