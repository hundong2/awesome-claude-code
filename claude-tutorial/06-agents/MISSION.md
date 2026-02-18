# 06단계 미션

---

## 미션 1: 내장 에이전트 체험 ⭐⭐

```bash
claude  # 인터랙티브 모드 시작
```

다음을 요청해서 에이전트가 자동으로 사용되는지 관찰:

```
"Explore 에이전트를 사용해서 이 awesome-claude-code 프로젝트에서
모든 마크다운 파일을 찾고 총 개수를 알려줘"
```

**관찰할 것**:
- Claude가 서브에이전트를 생성하는 메시지
- 에이전트가 독립적으로 작업하는 과정
- 결과가 메인 Claude로 돌아오는 과정

---

## 미션 2: 병렬 에이전트 실행 ⭐⭐⭐

다음 세 가지를 동시에 처리하도록 요청:

```
"다음 세 작업을 병렬로 처리해줘:
1. claude-tutorial 폴더의 모든 README.md 파일 목록
2. claude-tutorial 폴더의 모든 MISSION.md 파일 목록
3. claude-tutorial 폴더의 모든 PRACTICE.md 파일 목록

각각 파일 경로와 파일 크기를 포함해서 알려줘"
```

**기록**: 병렬 vs 순차 처리의 차이를 체감했는지

---

## 미션 3: 커스텀 에이전트 만들기 ⭐⭐⭐

이 튜토리얼을 도와주는 `tutorial-checker` 에이전트를 만드세요.

```bash
mkdir -p .claude/agents
```

`.claude/agents/tutorial-checker.md`:
```markdown
---
name: tutorial-checker
description: claude-tutorial의 학습 진도를 확인하고 다음 미션을 안내하는 에이전트
tools: Read, Glob, Grep
disallowedTools: Edit, Write, Bash
model: haiku
maxTurns: 5
---

당신은 학습 진도 확인 전문가입니다.

요청이 있을 때:
1. PROGRESS.md를 읽어서 현재 진도 파악
2. 각 단계의 PRACTICE.md를 읽어서 완료 여부 판단
3. 다음으로 해야 할 미션 안내
4. 격려 메시지 포함

한국어로 간결하게 답변하세요.
```

**테스트**:
```bash
claude -p "tutorial-checker 에이전트를 사용해서 내 학습 진도를 확인해줘"
```

---

## 미션 4: 에이전트 실행 확인 ⭐⭐

```bash
# 인터랙티브 모드에서
claude
/agents  # 에이전트 목록 확인
```

확인할 것:
- 내장 에이전트 목록
- 방금 만든 tutorial-checker 에이전트
- 각 에이전트의 설명과 도구 목록

---

## 미션 5: 에이전트로 코드 리뷰 ⭐⭐⭐

코드 리뷰 전용 에이전트를 만들어보세요.

`.claude/agents/code-reviewer.md` 작성:
- 읽기 전용 도구만 허용 (Edit/Write 금지)
- 보안 취약점 중점 검토
- 한국어로 보고

**테스트**:
```bash
# 테스트할 간단한 Python 코드 만들기
cat > /tmp/review_test.py << 'EOF'
import os
import subprocess

def get_user_data(user_id):
    # 데이터베이스에서 사용자 정보 가져오기
    query = f"SELECT * FROM users WHERE id = {user_id}"
    result = subprocess.run(f"mysql -e '{query}'", shell=True, capture_output=True)
    return result.stdout

password = "admin123"
api_key = "sk-1234567890abcdef"
EOF

claude -p "code-reviewer 에이전트로 /tmp/review_test.py를 리뷰해줘"
```

**보안 문제를 찾아내는지 확인** (SQL 인젝션, 하드코딩된 비밀번호 등)

---

## 미션 6: 도전 - 멀티 에이전트 워크플로우 ⭐⭐⭐⭐

전체 워크플로우를 에이전트 팀으로 처리:

```
"다음 워크플로우를 에이전트를 활용해서 처리해줘:

1. [Explore 에이전트] claude-tutorial 폴더 구조 분석
2. [분석] 현재 튜토리얼의 문제점이나 개선점 파악
3. [general-purpose 에이전트] 개선 제안서 작성

최종 결과를 /tmp/improvement-report.md에 저장해줘"
```

---

## 완료 체크

PRACTICE.md에 기록하고 `07-advanced/`로!
