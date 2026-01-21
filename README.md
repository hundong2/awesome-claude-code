# AWESOME CLAUDE 

## plugin 

- https://code.claude.com/docs/en/plugins

## plugin.json


|Field|Purpose|
|---|---|
|name|Unique identifier and skill namespace. Skills are prefixed with this (e.g., /my-first-plugin:hello).|
|description|	Shown in the plugin manager when browsing or installing plugins.|
|version|	Track releases using semantic versioning.|
|author|	Optional. Helpful for attribution.|

- For additional fields like homepage, repository, and license, see the full manifest schema.

## Test Plugin 

```sh
claude --plugin-dir ./my-first-plugin
/my-first-plugin:hello
```

## Add skill arguments 

- `$ARGUMENTS`

```
Make your skill dynamic by accepting user input. The $ARGUMENTS placeholder captures any text the user provides after the skill name.
```

## Flow of skill

1. skills/<any folder>/commands/command.md : Run first command with `$ARGUMENT`, Adding claude short cut commands   
2. skills/<any folder>/SKILL.md ( root action )

- Plugin manifest (.claude-plugin/plugin.json): describes your plugin’s metadata
- Commands directory (commands/): contains your custom skills
- Skill arguments ($ARGUMENTS): captures user input for dynamic behavior
