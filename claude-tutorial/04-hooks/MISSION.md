# 04단계 미션

---

## 미션 1: 현재 훅 설정 확인 ⭐

```bash
# 전역 설정에서 훅 확인
cat ~/.claude/settings.json | python3 -m json.tool 2>/dev/null | grep -A 20 '"hooks"' || echo "훅 없음"
```

이 프로젝트의 settings.json 확인:
```bash
cat .claude/settings.json 2>/dev/null || echo "없음"
```

---

## 미션 2: 첫 번째 훅 - 로깅 ⭐⭐

모든 Bash 명령어를 로그 파일에 기록하는 훅을 만드세요.

`.claude/settings.json`에 추가:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'INPUT=$(cat); CMD=$(echo \"$INPUT\" | python3 -c \"import sys,json; d=json.load(sys.stdin); print(d.get(\\\"tool_input\\\",{}).get(\\\"command\\\",\\\"\\\"))\"); echo \"[$(date)] $CMD\" >> /tmp/claude-bash-log.txt; echo \"$INPUT\"'"
          }
        ]
      }
    ]
  }
}
```

**테스트**:
```bash
claude -p "ls -la 실행해줘"
cat /tmp/claude-bash-log.txt  # 로그 확인
```

---

## 미션 3: 위험 명령어 차단 훅 ⭐⭐⭐

`rm -rf`를 포함한 명령어를 차단하는 훅을 만드세요.

**힌트**: 종료 코드 2로 종료하면 차단됩니다.

```bash
# 테스트 스크립트 작성
cat > /tmp/test-block-hook.sh << 'EOF'
#!/bin/bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('tool_input', {}).get('command', ''))
")

if echo "$CMD" | grep -qE "rm -rf|rmdir|rm -r"; then
  echo "🛑 위험한 삭제 명령어가 차단되었습니다: $CMD" >&2
  exit 2
fi

echo "$INPUT"
EOF
chmod +x /tmp/test-block-hook.sh
```

settings.json에 적용 후:
```bash
claude -p "rm -rf /tmp/test 실행해줘"
# → 차단 메시지가 보이는지 확인
```

---

## 미션 4: 완료 알림 훅 ⭐⭐

Claude가 응답을 완료할 때 터미널에 알림을 보내는 훅을 만드세요.

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo '\\a'  # 터미널 벨 소리"
          }
        ]
      }
    ]
  }
}
```

macOS라면 더 멋진 알림:
```json
{
  "type": "command",
  "command": "osascript -e 'display notification \"Claude가 완료했습니다!\" with title \"Claude Code\"'"
}
```

---

## 미션 5: 훅 디버깅 ⭐⭐⭐

훅이 받는 JSON 입력 구조를 직접 확인하세요.

```bash
# 디버그용 훅 추가
cat > /tmp/debug-hook.sh << 'EOF'
#!/bin/bash
INPUT=$(cat)
echo "$INPUT" > /tmp/last-hook-input.json
echo "$INPUT"  # 반드시 입력을 다시 출력해야 함
EOF
chmod +x /tmp/debug-hook.sh
```

settings.json에 적용 후 claude 실행, 명령어 요청 후:
```bash
cat /tmp/last-hook-input.json | python3 -m json.tool
```

**기록할 것**: JSON 구조에 어떤 필드들이 있는지

---

## 미션 6: 도전 - PostToolUse 자동화 ⭐⭐⭐⭐

파이썬 파일을 편집할 때마다 자동으로 구문 검사를 실행하는 훅:

```bash
# 테스트용 Python 파일 만들기
echo "print('hello')" > /tmp/test.py
```

PostToolUse 훅 작성:
- Edit 또는 Write 도구 사용 후
- 파일이 .py 파일이면
- `python3 -m py_compile` 로 구문 검사
- 에러 있으면 출력

**성공 기준**: .py 파일 편집 후 자동으로 구문 검사 실행

---

## 완료 체크

PRACTICE.md에 기록하고 `05-mcp/`로!
