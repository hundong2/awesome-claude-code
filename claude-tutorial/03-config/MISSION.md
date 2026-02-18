# 03단계 미션

---

## 미션 1: 현재 설정 파악 ⭐

```bash
# 전역 설정 확인
cat ~/.claude/settings.json 2>/dev/null || echo "파일 없음"

# 전역 CLAUDE.md 확인
cat ~/.claude/CLAUDE.md 2>/dev/null || echo "파일 없음"

# 이 프로젝트의 설정 확인
ls -la .claude/ 2>/dev/null || echo ".claude 폴더 없음"
```

**기록할 것**: 현재 어떤 설정이 적용되어 있는지 PRACTICE.md에 기록

---

## 미션 2: 프로젝트 CLAUDE.md 작성 ⭐⭐

이 `claude-tutorial` 프로젝트에 맞는 CLAUDE.md를 직접 작성하세요.

작성할 내용:
- 프로젝트 목적 설명
- 폴더 구조 설명
- 학습 진행 규칙 (예: 실습 결과는 PRACTICE.md에 기록)
- 하지 말 것 (예: 다른 사람의 PRACTICE.md 수정 금지)

```bash
# 작성 후 claude를 실행해서 제대로 읽히는지 확인
cd /Users/donghun2/workspace/awesome-claude-code/claude-tutorial
claude -p "이 프로젝트에 대해 설명해줘"
```

**성공 기준**: Claude가 CLAUDE.md의 내용을 반영해서 프로젝트를 설명함

---

## 미션 3: 전역 CLAUDE.md 개인화 ⭐⭐

`~/.claude/CLAUDE.md`에 당신만의 선호도를 추가하세요.

```bash
# 현재 내용 백업
cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup 2>/dev/null || true

# 에디터로 열기
open ~/.claude/CLAUDE.md  # macOS
# 또는 claude 인터랙티브 모드에서 /memory 사용
```

추가할 것:
- 선호하는 응답 언어 (한국어)
- 코드 스타일 선호도
- 반드시 지켜야 할 규칙

**성공 기준**: 새 claude 세션에서 설정한 선호도가 반영됨

---

## 미션 4: 권한 설정 실험 ⭐⭐⭐

`.claude/settings.json`을 만들어서 권한을 설정해보세요.

```bash
mkdir -p .claude
```

목표: 아래 규칙을 가진 settings.json 만들기
- `npm run *` 명령어 자동 허용
- `git status`, `git log` 자동 허용
- `rm -rf` 항상 거부
- `.env` 파일 읽기 거부

만들고 나서:
```bash
claude -p "현재 설정된 권한 규칙을 .claude/settings.json에서 읽어서 설명해줘"
```

---

## 미션 5: rules/ 폴더로 경로별 규칙 ⭐⭐⭐

마크다운 파일에만 적용되는 규칙을 만들어보세요.

```bash
mkdir -p .claude/rules
```

`.claude/rules/markdown.md` 작성:
```markdown
---
paths:
  - "**/*.md"
---

# 마크다운 파일 작성 규칙
- 한국어로 작성
- 제목은 항상 # 으로 시작
- 코드블록에는 언어 명시
- 각 섹션 사이에 --- 구분선 사용
```

**테스트**: 새 .md 파일 작성 요청 시 위 규칙이 적용되는지 확인

---

## 미션 6: /memory 명령어 마스터 ⭐⭐⭐

1. `claude` 실행
2. `/memory` 입력
3. 열리는 UI 탐색
4. 새 항목 추가해보기
5. 저장 후 `/clear` 로 컨텍스트 초기화
6. "내가 방금 memory에 뭘 추가했지?" 질문
7. Claude가 기억하는지 확인

---

## 도전 미션: 자동 메모리 관찰 ⭐⭐⭐⭐

Claude의 자동 메모리 시스템을 관찰하세요.

```bash
# 자동 메모리 파일 위치
ls ~/.claude/projects/

# 이 프로젝트의 자동 메모리
cat ~/.claude/projects/$(echo $PWD | tr '/' '-' | sed 's/^-//')/memory/MEMORY.md 2>/dev/null || echo "아직 없음"
```

1. `claude` 실행
2. 프로젝트에 대한 여러 대화를 나눔
3. 세션 종료 후 자동 메모리 파일 확인
4. Claude가 무엇을 기억했는지 관찰

---

## 완료 체크

PRACTICE.md에 기록하고 `04-hooks/`로!
