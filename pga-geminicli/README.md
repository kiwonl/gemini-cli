# pga-geminicli

이 프로젝트는 Terraform을 사용하여 Google Cloud VM을 설정합니다.

## 0. 환경설정

환경변수 설정
```bash
export PROJECT_ID="YOUR_PROJECT_ID" //qwiklabs-gcp-00-90a5c37a7501
export REGION="us-central1" 
```

terraform.tfvars 파일 업데이트
```bash
sed -i \
-e "s/your-gcp-project-id/$PROJECT/" \
-e "s/your-region/$REGION/" \
terraform.tfvars
```

## 1. Terraform 설치

```bash
terraform init
terraform plan
terraform apply
```

## 2. SSH를 통해 VM에 연결

VM은 외부 IP 주소 없이 생성되어, IAP를 통해서만 SSH 로액세스할 수 있습니다.
다음 `gcloud` 명령을 사용하여 VM에 연결합니다.

```bash
gcloud compute ssh cli-vm --zone $REGION --project $PROJECT
```

## Terraform 으로 생성되는 리소스
**google_project_service:** 다음 API를 활성화합니다.   
`dns.googleapis.com`   
`compute.googleapis.com`   
`iam.googleapis.com`   
**google_compute_network:** `gemini-vpc-net`이라는 이름의 VPC 네트워크를 생성합니다.   
**google_compute_subnetwork:** `vm1-subnet`이라는 이름의 서브넷을 생성합니다. (with Private Google Access) 
**google_compute_instance:** `cli-vm`이라는 이름의 VM 인스턴스를 생성합니다.   
**google_compute_firewall:** ICMP 및 SSH 트래픽을 허용하는 방화벽 규칙을 생성합니다.    
**google_project_iam_member:** 서비스 계정에 `roles/compute.instanceAdmin.v1` 및 `roles/iap.tunnelResourceAccessor` 역할을 부여합니다.  

## 3. Gemini CLI 설치

VM에 연결되면 Gemini CLI를 설치할 수 있습니다.
(Gemini CLI가 스크립트를 통해 설치될 수 있다고 가정하고 자리 표시자 명령을 제공합니다.)

```bash
mkdir geminicli && cd geminicli
```

Node.js 설치 스크립트 다운로드
```bash
curl -fsSL https://deb.nodesource.com/setup_24.x -o nodesource_setup.sh
```
Node.js 설치 스크립트 실행
```bash
sudo -E bash nodesource_setup.sh
```
Node.js 설치
```bash
sudo apt-get install -y nodejs
```
Gemini CLI 를 위한 환경 변수 설정
```bash
cat <<EOF >> ~/.bashrc 
export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
export GOOGLE_CLOUD_LOCATION="us-central1" 
export GOOGLE_GENAI_USE_VERTEXAI=true
EOF

source ~/.bashrc
```
애플리케이션 기본 인증 설정

```bash
gcloud auth application-default login
```
Gemini CLI 설치
```bash
sudo npm install -g @google/gemini-cli
```

## 프로젝트 구조

-   `main.tf`: 필요한 Google Cloud API를 활성화합니다.
-   `provider.tf`: Google Cloud provider를 구성합니다.
-   `network.tf`: VPC 네트워크 및 서브넷을 정의합니다.
-   `firewall.tf`: ICMP 및 SSH 트래픽을 허용하는 방화벽 규칙을 포함합니다.
-   `vm.tf`: Google Compute Engine VM 인스턴스를 정의합니다.
-   `iam.tf`: 서비스 계정에 대한 IAM 권한을 관리합니다.
-   `variable.tf`: 프로젝트에 사용된 모든 변수를 포함합니다.
-   `outputs.tf`: Terraform 프로젝트의 출력 값을 정의합니다.
-   `terraform.tfvars.example`: 변수 값에 대한 예제 파일입니다.