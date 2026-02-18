# 07단계 미션

---

## 미션 1: 자동 메모리 탐험 ⭐⭐

```bash
# 현재 자동 메모리 확인
ls ~/.claude/projects/ 2>/dev/null && echo "프로젝트 목록 있음" || echo "없음"

# 이 프로젝트의 자동 메모리
PROJECT_PATH=$(echo "/Users/donghun2/workspace/awesome-claude-code" | sed 's|/|-|g' | sed 's|^-||')
cat ~/.claude/projects/$PROJECT_PATH/memory/MEMORY.md 2>/dev/null || echo "아직 없음"
```

1. `claude` 실행
2. 이 프로젝트에 대해 여러 가지 질문 (빌드 방법, 구조 등)
3. 세션 종료
4. 자동 메모리 파일이 생성되었는지 확인
5. 무엇이 저장되었는지 기록

---

## 미션 2: Extended Thinking 비교 ⭐⭐⭐

같은 질문을 두 번 실행해서 차이를 비교하세요.

**질문**: "피보나치 수열을 구현하는 최적의 방법 5가지를 설계하고 각각의 시간복잡도와 공간복잡도를 분석해줘"

```bash
# 일반 모드
claude -p "피보나치 수열을 구현하는 최적의 방법 5가지를 설계하고 각각의 시간복잡도와 공간복잡도를 분석해줘"

# Extended Thinking 모드 (Ctrl+O로 사고 과정 표시)
claude  # 인터랙티브 모드
# Option+T 로 thinking 활성화
# 같은 질문 입력
```

**기록할 것**:
- 응답 품질 차이
- 응답 시간 차이
- 사고 과정에서 흥미로운 내용

---

## 미션 3: /plan 모드 안전 탐색 ⭐⭐

```bash
cd /Users/donghun2/workspace/awesome-claude-code
claude --permission-mode plan
```

plan 모드에서:
1. "이 프로젝트의 전체 구조를 분석하고 개선할 수 있는 점 5가지를 제안해줘"
2. 파일 변경을 요청해보기 → 거부되는지 확인
3. `Shift+Tab`으로 `acceptEdits` 모드로 전환
4. 같은 변경 요청 → 이번엔 실행되는지 확인

---

## 미션 4: Git Worktree 실험 ⭐⭐⭐

```bash
cd /Users/donghun2/workspace/awesome-claude-code

# 현재 브랜치 확인
git branch

# 새 worktree 생성 (실험용)
git worktree add /tmp/claude-tutorial-test test-branch 2>/dev/null || \
  git worktree add /tmp/claude-tutorial-test -b test-branch

# worktree에서 Claude 실행
cd /tmp/claude-tutorial-test
claude -p "이 폴더의 구조를 설명해줘"

# 원래 폴더에서도 Claude 실행 (별도 터미널에서)
# cd /Users/donghun2/workspace/awesome-claude-code && claude

# 정리
git worktree remove /tmp/claude-tutorial-test 2>/dev/null || true
```

---

## 미션 5: 비용 최적화 실험 ⭐⭐

같은 작업을 다른 모델로 실행해서 비용과 품질을 비교:

```bash
# Haiku로 빠른 탐색
claude --model claude-haiku-4-5-20251001 -p \
  "claude-tutorial 폴더의 각 단계를 한 줄씩 요약해줘"

# Sonnet으로 일반 작업
claude -p "claude-tutorial 폴더의 각 단계를 한 줄씩 요약해줘"
```

세션 후 `/cost`로 비용 비교

---

## 미션 6: 도전 - 나만의 고급 CLAUDE.md ⭐⭐⭐⭐

지금까지 배운 것을 바탕으로 최적화된 `~/.claude/CLAUDE.md`를 작성하세요.

포함할 내용:
- [ ] 응답 언어 및 스타일 선호도
- [ ] 자주 쓰는 프로젝트들의 컨텍스트
- [ ] 보안 규칙 (API 키, 비밀번호 관련)
- [ ] 코딩 컨벤션
- [ ] Claude에게 항상 해줬으면 하는 것 / 하지 말았으면 하는 것
- [ ] 자주 쓰는 명령어들

**성공 기준**: 새 세션에서 설정한 선호도가 모두 반영됨

---

## 완료 체크

PRACTICE.md에 기록하고 `08-workflows/`로!
