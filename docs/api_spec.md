# 🏎 BoxBox AI API Spec (v0.1.0)

> 이 문서는 `api/openapi.yaml`(OpenAPI Spec)을 요약한 가이드입니다.  
> Base: `/api/v1`

---

## 인증 & 공통 헤더

- 인증 방식
  - `Authorization: Bearer <JWT>`
- 공통 응답 헤더
  - `X-Request-Id`
  - `X-RateLimit-Remaining`

### 에러 포맷
```json
{
  "error": {
    "code": "invalid_argument",
    "message": "title must not be empty",
    "details": {}
  }
}
```

---

## 엔드포인트 개요

| 그룹 | 메서드 | 경로 | 설명 |
|---|---|---|---|
| rooms | POST | `/rooms` | 채팅방 생성 |
| rooms | GET | `/rooms` | 채팅방 목록 (페이지네이션) |
| rooms | GET | `/rooms/{room_id}` | 채팅방 조회/재입장 |
| rooms | DELETE | `/rooms/{room_id}` | 채팅방 삭제 |
| query | POST | `/query/stream` | LLM 질의 SSE 스트리밍 |
| health | GET | `/health` | 헬스 체크 (공개) |
| auth | GET | `/auth/me` | 인증 상태/프로필 확인 |

---

## 스키마 요약

### ChatRoom
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "title": "Dutch Grand Prix 2025 - F1 Race",
  "metadata": { "track": "Zandvoort", "team": "McLaren" },
  "archived": false,
  "created_at": "2025-09-01T12:00:00Z",
  "updated_at": "2025-09-01T12:00:00Z"
}
```

### ChatRoomsPage
```json
{
  "items": [ /* ChatRoom[] */ ],
  "page": 1,
  "limit": 20,
  "total": 40
}
```

### QueryRequest
```json
{
  "query": "맥라렌의 2025 시즌 전략을 요약해줘",
  "room_id": "550e8400-e29b-41d4-a716-446655440000",
  "mode": "H"  // 선택: H=Hard, M=Medium, S=Soft
}
```

---

## 🚀 사용 예시 (cURL)

### 1) 채팅방 생성
```bash
curl -X POST http://localhost:2025/api/v1/rooms \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Monza Debrief","metadata":{"team":"McLaren","session":"Race"}}' -i
```
- **성공 (201)**: `Location: /api/v1/rooms/<uuid>` 헤더 + `ChatRoom` 본문

### 2) 채팅방 목록 (정렬: `created_at` DESC)
```bash
curl "http://localhost:2025/api/v1/rooms?page=1&limit=20" \
  -H "x-api-key: $KEY"
```
- **성공 (200)**: `ChatRoomsPage` + `X-RateLimit-Remaining` 헤더

### 3) 채팅방 조회/재입장
```bash
curl "http://localhost:2025/api/v1/rooms/$ROOM_ID" \
  -H "Authorization: Bearer $TOKEN"
```

### 4) 채팅방 삭제
```bash
curl -X DELETE "http://localhost:2025/api/v1/rooms/$ROOM_ID" \
  -H "Authorization: Bearer $TOKEN" -i
```
- **성공 (204)**

### 5) 질의 스트리밍 (SSE)
```bash
curl -N -X POST http://localhost:2025/api/v1/query/stream \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query":"맥라렌의 2025 시즌 전략을 요약해줘","room_id":"'$ROOM_ID'","mode":"H"}'
```

### 6) 헬스 체크 (공개)
```bash
curl http://localhost:2025/api/v1/health
```

### 7) 인증 상태 확인
```bash
curl http://localhost:2025/api/v1/auth/me \
  -H "Authorization: Bearer $TOKEN"
```

---

## Postman

- `api/openapi.yaml`을 Import하여 자동으로 컬렉션 생성 가능

---

## 📝 변경 이력 (Changelog)

- **0.1.0**
  - ChatRoom CRUD(일부: C/R/D), 목록(page/limit/total)
  - `/query/stream` SSE + 모드(H/M/S) 옵션
  - `/auth/me`, `/health`
