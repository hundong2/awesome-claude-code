# 07단계: 고급 기능

## 이 단계에서 배울 것

Extended Thinking, 메모리 마스터, /plan 모드, Git worktree 병렬 작업, 비용 최적화 전략을 익힙니다.

---

## 7-1. 메모리 시스템 완전 정복

### 메모리 계층도

```
1순위: 관리자 정책 CLAUDE.md (읽기 전용)
2순위: ~/.claude/CLAUDE.md (전역 사용자 메모리)
3순위: ./CLAUDE.md (프로젝트 팀 메모리)
4순위: .claude/rules/*.md (경로별 규칙)
5순위: ./CLAUDE.local.md (프로젝트 개인 메모리)
6순위: ~/.claude/projects/.../MEMORY.md (자동 메모리)
```

### 자동 메모리 (Auto Memory)

Claude가 대화 중 발견한 중요한 정보를 자동으로 저장합니다.

```bash
# 자동 메모리 위치
~/.claude/projects/[프로젝트경로-를-로변환]/memory/MEMORY.md

# 확인 방법
ls ~/.claude/projects/
```

**자동 저장되는 것들**:
- 프로젝트 빌드/테스트 명령어
- 반복되는 패턴이나 컨벤션
- 사용자 선호도
- 자주 발생하는 오류와 해결책

### 자동 메모리 비활성화

```bash
CLAUDE_CODE_DISABLE_AUTO_MEMORY=1 claude
```

---

## 7-2. Extended Thinking (확장 사고)

Claude가 복잡한 문제를 더 깊이 생각하도록 합니다.

### 활성화 방법

```
# 단축키 (인터랙티브 모드)
Option+T (macOS) / Alt+T (Linux/Windows)

# 환경 변수
CLAUDE_CODE_EFFORT_LEVEL=high claude  # Opus 4.6 모델에서 최대 사고

# 설정 파일
# settings.json에서
{
  "alwaysThinkingEnabled": true
}
```

### 사고 과정 보기

```
# 인터랙티브 모드에서
Ctrl+O  → 상세 출력 모드 토글 (회색 이탤릭체로 사고 과정 표시)
```

### 언제 사용하나?

- 복잡한 알고리즘 설계
- 아키텍처 결정
- 디버깅 (여러 가능성 탐색)
- 수학/논리 문제

### 주의사항

- 토큰 사용량이 크게 증가
- 응답 시간 길어짐
- 간단한 질문에는 사용 불필요

---

## 7-3. /plan 모드

안전하게 코드를 분석하고 변경 전 계획을 세웁니다.

```bash
# plan 모드로 시작
claude --permission-mode plan

# 인터랙티브 모드에서 진입
/plan
```

**plan 모드에서 가능한 것**:
- 파일 읽기, 검색 (모든 읽기 작업)
- 변경 계획 수립
- 코드 분석

**plan 모드에서 불가능한 것**:
- 파일 쓰기/수정
- 명령어 실행
- 네트워크 요청

**실무 활용**:
```
1. plan 모드에서 변경 범위 파악
2. 계획 승인 후 Shift+Tab으로 모드 전환
3. acceptEdits 모드에서 실행
```

---

## 7-4. Git Worktree + Claude 병렬 작업

Git worktree를 사용하면 같은 저장소에서 여러 브랜치를 동시에 작업할 수 있습니다.

```bash
# 새 worktree 생성
git worktree add ../project-feature-a feature-a
git worktree add ../project-feature-b feature-b

# 각 폴더에서 독립적으로 Claude 실행
cd ../project-feature-a && claude &
cd ../project-feature-b && claude &

# 완료 후 worktree 정리
git worktree remove ../project-feature-a
```

**장점**:
- 브랜치 전환 없이 병렬 작업
- 각 작업이 독립적인 파일 시스템
- 충돌 위험 없음

---

## 7-5. 비용 최적화 전략

### 모델 선택 전략

```
Haiku (빠름, 저렴) → 탐색, 간단한 요약, 파일 검색
Sonnet (균형)       → 일반 코딩, 대부분의 작업
Opus (강력, 비쌈)  → 복잡한 아키텍처, 어려운 디버깅
```

### 컨텍스트 관리

```bash
# 컨텍스트 사용량 확인
/context

# 핵심만 남기고 압축
/compact "현재 구현 중인 기능과 관련된 내용만 유지"

# 새 주제 시작 시
/clear
```

### 서브에이전트로 컨텍스트 보호

```
# 대용량 작업은 서브에이전트에서
"Explore 에이전트를 사용해서 모든 파일을 분석해줘"
→ 메인 컨텍스트가 오염되지 않음
```

### 비용 모니터링

```
/cost    → 현재 세션 비용
/usage   → 플랜 한도 확인
```

### 캐시 활용

- 같은 파일을 여러 번 읽으면 자동으로 캐시 활용
- CLAUDE.md 내용은 캐시됨 (비용 절감)

---

## 7-6. 플러그인 시스템

```bash
# 인터랙티브 모드에서
/plugin  → 플러그인 탐색/관리

# 마켓플레이스에서 설치
/plugin install [플러그인이름]
```

---

## 다음 단계

MISSION.md 완료 후 `08-workflows/`로 이동하세요.
