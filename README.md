# Shevery Debloat Manager

Módulo ADB para Shevery/Shizuku.
## Recursos

- Lista dinamicamente os pacotes do usuário 0, incluindo pacotes de sistema removidos apenas para o usuário.
- Classificação dinâmica por origem e risco:
  - **Recomendado**: apps instalados pelo usuário/terceiros.
  - **Avançado**: bloat e componentes opcionais conhecidos do fabricante, além de componentes OEM não centrais detectados dinamicamente.
  - **Esperto**: apps/componentes de sistema que exigem revisão porque podem remover funções usadas.
  - **Inseguro**: componentes críticos/protegidos, bloqueados para ações destrutivas.
- Detecta o fabricante por `ro.product.manufacturer` e `ro.product.brand` e reconhece namespaces OEM comuns.
- Pesquisa e filtros por categoria e estado:
  - Instalado/ativado
  - Desativado
  - Desinstalado
- Contadores por categoria e pelos filtros atualmente aplicados.
- Desativar, ativar, desinstalar e restaurar pacotes compatíveis.
- Ações em massa somente sobre pacotes realmente elegíveis nos filtros atuais.
- Proteção contra ações destrutivas em componentes críticos.
- Catálogo local em `data/catalog.json` usado para exceções/descrições conhecidas.
- Usa `pm uninstall -k --user 0` e, para pacotes de sistema ainda existentes, `pm install-existing --user 0`.
- Sem root obrigatório: usa a ponte WebUI do Shevery com Shizuku ativo.

## Estrutura

`module.prop`, `action.sh`, `banner.png`, `data/` e `webui/index.html`.

O formato segue a documentação oficial do Shevery: `module.prop` na raiz, WebUI em `webui/index.html` e `usesShellBridge=true` para acesso a `window.Shizuku`.

## Importante

A categoria indica o nível recomendado de atenção, não uma garantia universal de que remover um pacote seja seguro em todo aparelho/ROM. Pacotes OEM desconhecidos com sinais de função central ficam em **Esperto**, não em **Avançado**.

Apps instalados pelo usuário são classificados como **Recomendado** por serem apps não pertencentes ao sistema, mas a desinstalação deles pode remover o APK completamente. Nesse caso, `pm install-existing` normalmente não consegue restaurá-los. Para manter reversibilidade, prefira **Desativar**.

## Recuperação

- Desativado -> `pm enable --user 0 pacote`
- Pacote de sistema desinstalado apenas para o usuário -> `pm install-existing --user 0 pacote`

O módulo não apaga fisicamente APKs da partição de sistema.


## Correções de segurança e robustez — 1.2.1

- Comandos `pm` recebem os identificadores de pacote com quoting seguro antes de serem enviados ao shell.
- A interface não injeta nomes de pacotes em handlers `onclick`; os botões usam índices internos e listeners.
- A ponte `window.Shizuku.exec()` aceita respostas em objeto ou JSON e falha de forma controlada quando a resposta é inválida.
- Catálogo e lista de proteção são validados durante o carregamento e erros HTTP não são silenciosamente aceitos.
- Ações recebidas pela interface passam por uma lista explícita de operações permitidas.
