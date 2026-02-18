# 06단계: 에이전트 - 서브에이전트 & 팀

## 이 단계에서 배울 것

서브에이전트를 활용해서 복잡한 작업을 병렬로 처리하고, 커스텀 에이전트를 만드는 방법을 익힙니다.

---

## 6-1. 에이전트란?

에이전트는 **특정 역할과 도구를 가진 독립적인 Claude 인스턴스**입니다.

```
메인 Claude (오케스트레이터)
    ↓
Task 도구로 서브에이전트 생성
    ├── Explore 에이전트 (코드베이스 탐색)
    ├── Bash 에이전트 (명령어 실행)
    └── general-purpose 에이전트 (복잡한 작업)
```

**핵심 장점**:
- 병렬 처리 (여러 작업 동시 진행)
- 컨텍스트 보호 (대용량 작업을 별도 컨텍스트에서)
- 역할 분리 (각자 최적화된 도구)

---

## 6-2. 내장 에이전트 종류

| 에이전트 | 모델 | 도구 | 용도 |
|---------|------|------|------|
| `Explore` | Haiku (빠름) | 읽기 전용 | 코드 탐색, 파일 검색 |
| `Plan` | Sonnet | 읽기 전용 | 계획 수립, 분석 |
| `Bash` | Sonnet | Bash만 | 명령어 실행 |
| `general-purpose` | Sonnet | 모든 도구 | 복잡한 다단계 작업 |

---

## 6-3. 에이전트 사용하기

인터랙티브 모드에서 Task 도구를 통해 에이전트 실행:

```
# 탐색 에이전트 사용
"이 프로젝트에서 모든 API 엔드포인트를 찾아줘"
→ Claude가 자동으로 Explore 에이전트를 사용

# 명시적 에이전트 지정
"general-purpose 에이전트를 사용해서 README.md를 분석해줘"
```

---

## 6-4. 커스텀 에이전트 만들기

에이전트 파일 위치:
- 프로젝트: `.claude/agents/`
- 전역: `~/.claude/agents/`

**파일 형식** (`.claude/agents/code-reviewer.md`):

```markdown
---
name: code-reviewer
description: 코드 품질, 보안, 성능을 검토하는 전문 리뷰어. 코드 리뷰 요청 시 사용.
tools: Read, Grep, Glob, Bash
disallowedTools: Edit, Write
model: sonnet
permissionMode: default
maxTurns: 20
---

당신은 시니어 소프트웨어 엔지니어로서 코드 리뷰를 전문으로 합니다.

리뷰 시 확인할 것:
1. 버그 및 로직 오류
2. 보안 취약점 (SQL 인젝션, XSS, 인증 등)
3. 성능 문제
4. 코딩 컨벤션 위반
5. 테스트 누락

출력 형식:
- 심각도별 분류: 🔴 Critical / 🟡 Warning / 🟢 Info
- 구체적인 파일과 라인 번호 명시
- 개선 제안 포함
```

---

## 6-5. 에이전트 설정 옵션

```markdown
---
name: my-agent          # 에이전트 이름 (필수)
description: ...        # 언제 사용되는지 설명 (필수)
model: sonnet           # sonnet / opus / haiku / inherit
permissionMode: default # default / acceptEdits / plan / dontAsk / bypassPermissions
tools: Read, Bash       # 허용할 도구 목록
disallowedTools: Edit   # 금지할 도구 목록
maxTurns: 10            # 최대 턴 수
memory: user            # user / project / local
mcpServers:             # 사용할 MCP 서버
  - github
  - notion
---
```

---

## 6-6. 병렬 에이전트 실행

Claude에게 여러 작업을 동시에 처리하도록 요청:

```
"다음 세 작업을 병렬로 처리해줘:
1. src/ 폴더의 모든 TypeScript 파일 목록 찾기
2. tests/ 폴더의 테스트 커버리지 분석
3. package.json의 의존성 보안 취약점 확인"
```

Claude가 자동으로 여러 서브에이전트를 생성해서 병렬 처리합니다.

---

## 6-7. 에이전트 팀 (고급)

여러 에이전트가 지속적으로 협업하는 팀 구성:

```bash
# 팀 기능 활성화 (settings.json)
{
  "enabledFeatures": ["agent-teams"]
}
```

팀 내 에이전트들은:
- 태스크 목록 공유
- 서로 메시지 전달
- 병렬 작업 분담

---

## 6-8. 에이전트 활용 패턴

### 패턴 1: 코드베이스 탐색 후 수정

```
1. Explore 에이전트로 관련 파일 찾기 (빠름, 저렴)
2. 발견된 파일들만 main Claude에서 수정
```

### 패턴 2: 리서치 & 구현 분리

```
1. general-purpose 에이전트로 문서/API 조사
2. main Claude가 조사 결과 바탕으로 구현
```

### 패턴 3: 테스트 격리

```
1. Bash 에이전트로 테스트 실행 (출력이 많아도 main context 안 오염)
2. main Claude는 결과만 받아서 판단
```

---

## 다음 단계

MISSION.md 완료 후 `07-advanced/`로 이동하세요.
