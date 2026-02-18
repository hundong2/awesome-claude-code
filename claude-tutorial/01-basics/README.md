# 01단계: 기초 - CLI 명령어 & 기본 사용법

## 이 단계에서 배울 것

Claude Code의 핵심 CLI 명령어와 플래그들을 익힙니다.
모든 실습은 **직접 터미널에서 실행**해야 합니다.

---

## 1-1. 설치 확인 & 버전 정보

```bash
# 설치 확인
claude --version

# 상태 확인
claude --help
```

**확인할 것**: 버전 번호가 출력되는지 확인

---

## 1-2. 첫 번째 질문 (`-p` 플래그)

`-p` (--print) 플래그는 **단발성 질문**에 사용합니다.
응답 후 자동으로 종료됩니다.

```bash
# 가장 기본적인 사용법
claude -p "안녕하세요. 당신은 누구인가요?"

# 코드 관련 질문
claude -p "Python으로 Hello World를 출력하는 코드를 작성해줘"

# 파이프라인 활용
echo "def add(a, b): return a + b" | claude -p "이 코드를 설명해줘"
```

---

## 1-3. 인터랙티브 REPL 모드

```bash
# 인터랙티브 모드 시작
claude

# 특정 질문으로 시작
claude "이 프로젝트 구조를 설명해줘"

# 특정 모델로 시작
claude --model claude-opus-4-6 "복잡한 알고리즘 설계 도와줘"
```

**REPL 종료 방법**:
- `Ctrl+D` 또는 `/exit` 입력

---

## 1-4. 세션 관리 (저장 & 이어하기)

```bash
# 가장 최근 세션 이어하기
claude -c
claude --continue

# 세션 목록 보고 선택해서 이어하기
claude -r
claude --resume

# 특정 세션 이어하기 (세션 ID 또는 이름 사용)
claude -r "my-session-name"
```

**실습**: 세션을 하나 시작하고 `/rename test-session`으로 이름 붙인 후 종료. 그 다음 `claude -r "test-session"`으로 이어보기

---

## 1-5. 헤드리스 모드 & 파이프라인

```bash
# JSON 출력으로 받기 (스크립팅에 유용)
claude -p "1+1은?" --output-format json

# 파일 내용을 입력으로 전달
cat README.md | claude -p "이 문서를 한 줄로 요약해줘"

# 결과를 파일로 저장
claude -p "Python 정렬 알고리즘 예제" > output.py

# 최대 턴 수 제한
claude -p "간단한 웹 스크레이퍼 만들어줘" --max-turns 3
```

---

## 1-6. 주요 플래그 실습

```bash
# 상세 출력 (Claude의 생각 과정 확인)
claude --verbose -p "피보나치 수열을 재귀로 구현해줘"

# 특정 모델 지정
claude --model claude-haiku-4-5-20251001 -p "빠른 요약 필요해"

# 권한 모드 설정
claude --permission-mode acceptEdits  # 파일 편집 자동 승인
claude --permission-mode plan         # 읽기 전용 계획 모드

# 추가 디렉토리 접근 허용
claude --add-dir ../docs -p "docs 폴더의 내용을 정리해줘"

# 사용할 도구 제한
claude --tools "Read,Glob,Grep" -p "코드 검색만 해줘"
```

---

## 핵심 플래그 요약표

| 플래그 | 단축 | 설명 |
|--------|------|------|
| `--print` | `-p` | 단발성 질문, 응답 후 종료 |
| `--continue` | `-c` | 최근 세션 이어하기 |
| `--resume` | `-r` | 세션 선택해서 이어하기 |
| `--model` | | 모델 지정 |
| `--verbose` | | 상세 출력 |
| `--output-format` | | text/json/stream-json |
| `--permission-mode` | | 권한 모드 설정 |
| `--max-turns` | | 최대 대화 턴 수 |
| `--add-dir` | | 추가 접근 허용 폴더 |
| `--tools` | | 사용 가능 도구 제한 |

---

## 다음 단계

1. MISSION.md의 모든 미션을 완료하세요
2. PRACTICE.md에 결과를 기록하세요
3. 완료되면 `02-interactive/`로 이동하세요
