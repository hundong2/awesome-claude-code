# 03단계: 설정 - CLAUDE.md & settings.json

## 이 단계에서 배울 것

Claude가 당신의 프로젝트를 이해하도록 메모리를 설정하고,
권한과 동작을 커스터마이징하는 방법을 익힙니다.

---

## 3-1. CLAUDE.md 파일 계층 구조

Claude는 세션 시작 시 여러 위치의 CLAUDE.md를 자동으로 읽습니다.

```
우선순위 (높음 → 낮음)
1. /Library/.../ClaudeCode/CLAUDE.md  → 조직 전체 정책 (관리자)
2. ~/.claude/CLAUDE.md               → 내 모든 프로젝트에 적용
3. ./CLAUDE.md                        → 현재 프로젝트 (팀 공유)
4. ./.claude/CLAUDE.md               → 현재 프로젝트 (팀 공유)
5. ./CLAUDE.local.md                  → 현재 프로젝트 (나만)
6. ~/.claude/projects/.../MEMORY.md  → Claude의 자동 메모리
```

### 직접 확인해보기

```bash
# 내 전역 CLAUDE.md 확인
cat ~/.claude/CLAUDE.md

# 이 프로젝트의 CLAUDE.md 확인
cat ./CLAUDE.md

# /memory 명령어로 모든 메모리 파일 관리
# (claude 인터랙티브 모드에서)
/memory
```

---

## 3-2. 프로젝트 CLAUDE.md 작성하기

프로젝트 루트에 CLAUDE.md를 만들면 Claude가 항상 이 정보를 기억합니다.

```markdown
# 프로젝트명

## 빌드 & 테스트
- 빌드: `npm run build`
- 테스트: `npm test`
- 린트: `npm run lint`

## 코딩 컨벤션
- 들여쓰기: 2칸 공백
- 따옴표: 작은따옴표 사용
- 함수명: camelCase

## 중요 파일
- `src/main.ts`: 앱 진입점
- `src/config.ts`: 설정
- `tests/`: 모든 테스트

## 하지 말 것
- `node_modules/` 수정 금지
- `.env` 파일 직접 수정 금지
- main 브랜치에 직접 push 금지
```

### 파일 임포트 (@ 문법)

```markdown
# CLAUDE.md에서 다른 파일 참조하기
자세한 내용은 @README.md 참고
API 명세는 @docs/api.md 참고
```

---

## 3-3. 사용자 전역 CLAUDE.md

`~/.claude/CLAUDE.md`에 작성하면 **모든 프로젝트**에 적용됩니다.

```markdown
# 전역 설정

## 내 선호도
- 한국어로 대화
- 코드 예시 항상 포함
- 간결하게 설명

## 보안 규칙
- API 키나 비밀번호 절대 코드에 직접 넣지 말 것
- 환경변수 (.env) 사용 권장

## 작업 방식
- 큰 변경 전 항상 계획 먼저 세우기
- 테스트 코드 함께 작성하기
```

```bash
# 편집하기
claude  # 인터랙티브 모드에서
/memory # 메모리 파일 관리 UI 열기
```

---

## 3-4. settings.json 구조

위치: `.claude/settings.json` (프로젝트) 또는 `~/.claude/settings.json` (전역)

```json
{
  "model": "claude-sonnet-4-5-20250929",
  "permissions": {
    "allow": ["Bash(npm run *)", "Bash(git status)", "Read"],
    "ask": ["Bash(git push *)", "Bash(rm *)"],
    "deny": ["Bash(curl *)", "Read(./.env)"],
    "defaultMode": "acceptEdits"
  },
  "env": {
    "NODE_ENV": "development"
  }
}
```

### 주요 설정 필드

| 필드 | 설명 | 예시 |
|------|------|------|
| `model` | 기본 모델 | `"claude-sonnet-4-5-20250929"` |
| `permissions.allow` | 항상 허용 | `["Bash(npm *)", "Read"]` |
| `permissions.ask` | 물어보고 실행 | `["Bash(git push *)"]` |
| `permissions.deny` | 항상 거부 | `["Read(.env)"]` |
| `permissions.defaultMode` | 기본 모드 | `"acceptEdits"` |
| `env` | 환경 변수 | `{"NODE_ENV": "dev"}` |

---

## 3-5. 권한 규칙 상세 문법

```json
{
  "permissions": {
    "allow": [
      "Bash",                    // 모든 bash 허용
      "Bash(npm run *)",         // npm run으로 시작하는 명령만
      "Bash(git * main)",        // main 포함하는 git 명령
      "Read",                    // 모든 파일 읽기 허용
      "Read(./src/*)",           // src 폴더만 읽기 허용
      "WebFetch(domain:github.com)" // github.com만 허용
    ],
    "deny": [
      "Read(./.env)",            // .env 읽기 금지
      "Bash(rm -rf *)"           // rm -rf 금지
    ]
  }
}
```

---

## 3-6. .claude/rules/ 폴더 (경로별 규칙)

특정 파일 경로에만 적용되는 규칙을 만들 수 있습니다.

```bash
mkdir -p .claude/rules
```

`.claude/rules/typescript.md`:
```markdown
---
paths:
  - "src/**/*.ts"
  - "tests/**/*.test.ts"
---

# TypeScript 규칙
- strict 모드 사용
- 타입 any 사용 금지
- 모든 함수에 반환 타입 명시
```

---

## 다음 단계

MISSION.md 완료 후 `04-hooks/`로 이동하세요.
