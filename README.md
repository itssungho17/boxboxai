# 🏎 BoxBoxAI — AI Agent Orchestration (In progress)

## 🔑 프로젝트 개요

이 Repo는 **RAG**와 **Multi-agent 기반 Deep Research**로 구성된 **AI 에이전트 오케스트레이션 시스템** 예제입니다.  
[LangChain](https://www.langchain.com/), [LangGraph](https://www.langchain.com/langgraph), [FastAPI](https://fastapi.tiangolo.com/), [Qdrant](https://qdrant.tech/), [Flutter](https://flutter.dev)를 사용하여 개발되었습니다.

> 🎯 Chat UX 기반으로 **F1(Formula 1)** 관련 질의에 답변하는 에이전트를 구현하였습니다.  
> 사용자 질의에 따라 응답 시간 및 깊이를 3단계로 구분하여 답변합니다.  
> 로컬에서 실행 가능하며 `.env` 설정으로 모델을 바꿀 수 있게 구성하였습니다.

---

## ✨ 주요 기능

- **엔드 투 엔드 워크플로우**  
  - 전체 플로우를 포괄하는 **AI 오케스트레이션 시스템**  
  - 문서 인덱싱 → 프로필 라우팅 → RAG → 멀티 에이전트 심층 리서치 → 프런트엔드 UX  

- **로컬 실행**  
  - 🗄 **Qdrant**: Docker Desktop 기반 로컬 벡터 DB  
  - 🧠 **Ollama**: 로컬 LLM 실행 환경  
  - 🔄 `.env` 설정만으로 **OpenAI/Gemini ↔ Local LLM** 토글 가능  

- **라우팅 (H/M/S)**  
  - 사용자 질의에 따라 응답 시간 및 깊이를 동적으로 결정  
    - **H (Hard)**: 다중 루프, 심층 분석  
    - **M (Medium)**: 균형 잡힌 성능/비용  
    - **S (Soft)**: 빠르고 가벼운 응답  

- **RAG (Retrieval-Augmented Generation)**  
  - Retrieval → Grade → Query Rewriting (HyDE) → Fusion/Web Search → Generation  
  - 최소 2개 이상의 citation을 포함해 **출처 기반 응답** 제공  

- **Deep Research (멀티 에이전트 루프)**  
  - **Scope:** 사용자 질의 명확화, 브리프 초안 생성  
  - **Research:** Supervisor → Sub-agents(Scout/Analyst/Critic)  
  - **Write:** Editor가 최종 One-Shot Report 생성  

---

## ⚙️ 사전 조건

- [Docker Desktop](https://www.docker.com/products/docker-desktop) 설치 필수  
- Python 3.12 이상 + [uv](https://docs.astral.sh/uv) 환경 권장  
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 설치 — 프런트엔드 실행 시 필요  

---

## 🚀 실행 방법

### 1. 인프라 (Qdrant with Docker Compose)

> 💡 `make help`로 사용 가능한 명령어를 확인할 수 있습니다. ([Makefile](./Makefile) 파일 참조)  

```bash
# Qdrant 시작
make up

# Qdrant 중지
make down

# Qdrant 헬스 체크
make qdrant-health
```

### 2. 백엔드

```bash
# 의존성 설치
uv sync

# Qdrant 실행 및 헬스 체크
make up
make qdrant-health

# API 서버 실행
uvicorn backend.api.main:app --reload
```

### 3. 프런트엔드

```bash
cd frontend
flutter clean
flutter pub get
flutter run
```
---

## 📅 개발 일정 (In progress)

- ✅ 데이터 모델링 및 도메인 모델 정의
- ✅ API 설계
- 🚧 API 구현
- ⏳ RAG 인덱싱 파이프라인 구현
- ⏳ LLM 라우터 구현
- ⏳ RAG 그래프 구현
- ⏳ Deep Research 그래프 구현
- ⏳ API 및 그래프 연동
- ⏳ 프런트엔드 설계
- ⏳ 채팅 기능 (스트리밍) 구현
- ⏳ 채팅 기록 보기 기능 구현
- ⏳ 라우터 수동 선택 기능 추가
- ⏳ MCP 툴 연동

---

## 📜 라이선스

### 🏎 Engineered with Attitude by **itssungho**

MIT © 2025 **Sung-Ho Son** — 상세내용은 [LICENSE](./LICENSE) 파일 참조
