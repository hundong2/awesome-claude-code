# 08단계 미션 - 실전 통합 프로젝트

이 단계의 미션은 실제 개발 시나리오입니다.

---

## 미션 1: 새 프로젝트 온보딩 시뮬레이션 ⭐⭐

처음 보는 프로젝트를 분석하세요.

```bash
# awesome-claude-code 프로젝트를 "처음 보는 것처럼" 분석
cd /Users/donghun2/workspace/awesome-claude-code
claude -p "이 프로젝트를 처음 접한 신입 개발자 입장에서:
1. 프로젝트 목적과 구조 설명
2. 기여하려면 뭘 알아야 하는지
3. 처음 해볼 만한 작업
을 정리해줘"
```

이 결과를 `ONBOARDING.md`로 저장:
```bash
claude -p "[위와 같은 프롬프트]" > /tmp/onboarding.md
cat /tmp/onboarding.md
```

---

## 미션 2: 자동화 스크립트 만들기 ⭐⭐⭐

매일 아침 프로젝트 상태를 요약해주는 스크립트:

```bash
cat > ~/claude-daily-report.sh << 'SCRIPT'
#!/bin/bash

cd /Users/donghun2/workspace/awesome-claude-code

echo "=== 일일 Claude Code 리포트 ==="
echo "날짜: $(date)"
echo ""

# Git 상태 요약
echo "## Git 상태"
git log --oneline -5 | claude -p "최근 커밋 5개를 한 줄로 요약해줘"

echo ""
echo "## 변경된 파일"
git status --short | claude -p "변경된 파일들의 상태를 간단히 설명해줘"

echo ""
echo "리포트 완료!"
SCRIPT
chmod +x ~/claude-daily-report.sh

# 실행 테스트
~/claude-daily-report.sh
```

---

## 미션 3: CI/CD 스타일 코드 검사 ⭐⭐⭐

커밋 전 자동 검사 스크립트:

```bash
cat > .git/hooks/pre-commit << 'HOOK'
#!/bin/bash

echo "🤖 Claude Code 사전 검사 중..."

# 스테이징된 파일 목록
STAGED=$(git diff --cached --name-only)

if [ -z "$STAGED" ]; then
  echo "스테이징된 파일 없음"
  exit 0
fi

# Claude로 검사
REVIEW=$(git diff --cached | claude -p "이 코드 변경사항에서:
1. 하드코딩된 비밀번호나 API 키가 있나요?
2. 명백한 버그가 있나요?
있으면 '⚠️ 문제 발견:' 로 시작해서 알려주세요.
없으면 '✅ 검사 통과' 라고만 답해주세요.")

echo "$REVIEW"

if echo "$REVIEW" | grep -q "⚠️"; then
  echo "커밋을 중단합니다. 문제를 수정 후 다시 시도하세요."
  exit 1
fi

exit 0
HOOK
chmod +x .git/hooks/pre-commit

echo "pre-commit 훅 설치 완료!"
```

**테스트**:
```bash
# 문제 있는 코드로 테스트
echo "password = 'admin123'" > test_secret.py
git add test_secret.py
git commit -m "test"  # 차단되어야 함
git checkout test_secret.py
git rm test_secret.py 2>/dev/null
```

---

## 미션 4: 개인 지식 베이스 만들기 ⭐⭐⭐

Claude와 대화하면서 학습한 내용을 자동으로 기록하는 시스템:

```bash
# 지식 베이스 폴더
mkdir -p ~/claude-knowledge-base

# 카테고리별 정리 스크립트
cat > ~/save-knowledge.sh << 'SCRIPT'
#!/bin/bash

CATEGORY=$1  # python, bash, git 등
TOPIC=$2     # 주제

echo "# $TOPIC" >> ~/claude-knowledge-base/$CATEGORY.md
echo "날짜: $(date)" >> ~/claude-knowledge-base/$CATEGORY.md
echo "" >> ~/claude-knowledge-base/$CATEGORY.md

claude -p "$TOPIC 에 대해 핵심만 정리해줘. 예시 코드 포함." \
  >> ~/claude-knowledge-base/$CATEGORY.md

echo "" >> ~/claude-knowledge-base/$CATEGORY.md
echo "---" >> ~/claude-knowledge-base/$CATEGORY.md

echo "저장 완료: ~/claude-knowledge-base/$CATEGORY.md"
SCRIPT
chmod +x ~/save-knowledge.sh

# 테스트
~/save-knowledge.sh python "파이썬 데코레이터 패턴"
cat ~/claude-knowledge-base/python.md
```

---

## 졸업 미션: 나만의 Claude 활용 가이드 ⭐⭐⭐⭐⭐

지금까지 8단계를 완료하셨습니다!
최종 미션: 본인만의 Claude Code 활용 가이드를 작성하세요.

```bash
claude  # 인터랙티브 모드
```

요청:
```
"이 claude-tutorial 폴더의 모든 PRACTICE.md 파일을 읽어서
내가 배운 내용들을 바탕으로 나만의 Claude Code 활용 가이드를 작성해줘.
MY-CLAUDE-GUIDE.md 파일로 저장해줘.

포함할 것:
1. 내가 가장 유용하다고 생각하는 기능 TOP 5
2. 나의 일상적인 워크플로우
3. 주의해야 할 함정들
4. 나만의 팁과 트릭
5. 앞으로 더 탐구하고 싶은 것들"
```

**완료 기준**: `MY-CLAUDE-GUIDE.md` 파일 생성 및 내용 확인

---

## 🎓 수료 체크리스트

```
[ ] 01-basics: CLI 명령어 마스터
[ ] 02-interactive: 슬래시 명령어 & 단축키 마스터
[ ] 03-config: CLAUDE.md & settings.json 설정
[ ] 04-hooks: 훅 자동화 구현
[ ] 05-mcp: MCP 서버 추가 & 활용
[ ] 06-agents: 커스텀 에이전트 만들기
[ ] 07-advanced: 고급 기능 활용
[ ] 08-workflows: 실전 워크플로우 구축
[ ] MY-CLAUDE-GUIDE.md 작성 완료
```

모두 완료하셨나요? 🎉
당신은 이제 Claude Code 전문가입니다!
