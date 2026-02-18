# 08단계: 실전 워크플로우

## 이 단계에서 배울 것

지금까지 배운 모든 기능을 실제 개발 시나리오에서 활용합니다.

---

## 8-1. 코드베이스 빠른 파악

새 프로젝트를 처음 접할 때:

```bash
cd [프로젝트 폴더]

# 1단계: 전체 구조 파악
claude -p "이 프로젝트의 구조를 분석해줘:
- 주요 폴더와 역할
- 기술 스택
- 진입점 (main 파일)
- 빌드/실행 방법"

# 2단계: 인터랙티브로 깊이 파기
claude  # 인터랙티브 모드
# "인증 시스템이 어떻게 동작하는지 설명해줘"
# "데이터 흐름을 다이어그램으로 그려줘"
# "가장 복잡한 부분이 어디야?"
```

---

## 8-2. 버그 수정 워크플로우

```bash
# 1. 에러 메시지와 함께 시작
claude "다음 에러가 발생해:
[에러 메시지 붙여넣기]
원인이 뭔지 분석해줘"

# 2. 관련 파일 자동 탐색
# → Claude가 자동으로 Grep, Glob으로 관련 코드 찾음

# 3. 수정 계획 수립 (plan 모드)
# Shift+Tab으로 plan 모드 진입 후 계획 검토

# 4. 수정 실행
# Shift+Tab으로 acceptEdits 모드 전환

# 5. 테스트
# "수정된 코드를 테스트해줘"
```

---

## 8-3. claude -p로 CI/CD 통합

```yaml
# GitHub Actions 예시
name: AI Code Review
on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code
      - name: AI Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          git diff HEAD~1 | claude -p "이 PR의 코드 변경사항을 리뷰해줘:
          - 버그 가능성
          - 보안 취약점
          - 성능 문제
          - 코드 품질" --output-format json > review.json
      - name: Comment PR
        # review.json 내용을 PR 코멘트로 추가
```

---

## 8-4. JSON 출력으로 스크립팅

```bash
# 파일 분석 결과를 JSON으로
claude -p "이 폴더의 Python 파일들을 분석하고 각 파일의 함수 목록을 JSON으로 반환해줘" \
  --output-format json | python3 -m json.tool

# jq로 파싱
claude -p "시스템 상태를 JSON으로 알려줘" --output-format json | jq '.result'

# 반복 처리
for file in *.py; do
  echo "분석 중: $file"
  claude -p "$(cat $file)를 분석해서 복잡도를 1-10으로 평가해줘" --output-format json
done
```

---

## 8-5. 코드 리뷰 자동화

```bash
# PR 전 자동 리뷰
git diff --staged | claude -p "커밋하기 전 이 변경사항을 검토해줘:
1. 버그나 논리적 오류
2. 하드코딩된 값 (API 키, URL 등)
3. 에러 처리 누락
4. 테스트 필요성"

# 특정 파일 심층 리뷰
claude -p "@src/auth.py 이 파일의 보안을 철저히 검토해줘"
```

---

## 8-6. 개발 생산성 향상 팁

### 팁 1: 세션 이름 체계

```bash
# 기능별 세션 네이밍
# [날짜]-[기능]-[상태] 형식
claude  # 시작 후
/rename 20240218-auth-feature-wip
```

### 팁 2: CLAUDE.md로 프로젝트 온보딩

팀원이 새로 합류했을 때:
```markdown
# 팀 CLAUDE.md 예시
## 중요 명령어
- 실행: `docker-compose up`
- 테스트: `pytest tests/ -v`
- 배포: `./deploy.sh staging`

## 코딩 규칙
- PR 전 반드시 lint 통과
- 테스트 커버리지 80% 이상 유지
```

### 팁 3: 복잡한 리팩토링

```
1. plan 모드에서 전체 계획 수립
2. 에이전트로 영향 범위 파악
3. 작은 단위로 나눠서 실행
4. 각 단계마다 테스트
```

### 팁 4: 학습 가속화

```bash
# 모르는 코드 즉시 이해
cat 복잡한_파일.py | claude -p "이 코드를 초등학생도 이해할 수 있게 설명해줘"

# 패턴 학습
claude -p "이 코드베이스에서 사용하는 디자인 패턴들을 모두 찾아서 설명해줘"
```

---

## 나만의 워크플로우 만들기

배운 모든 기능을 조합해서 당신만의 최적 워크플로우를 만드세요.

### 체크리스트

- [ ] 자주 쓰는 명령어를 CLAUDE.md에 문서화
- [ ] 반복 작업을 훅으로 자동화
- [ ] 자주 쓰는 에이전트 커스텀
- [ ] CI/CD에 Claude 통합
- [ ] 팀 CLAUDE.md 작성

---

## 졸업 미션

모든 단계를 완료한 후, PROGRESS.md의 모든 체크박스를 채우세요.
그리고 이 튜토리얼 전체를 돌아보며 자신만의 핵심 정리 문서를 작성하세요.
