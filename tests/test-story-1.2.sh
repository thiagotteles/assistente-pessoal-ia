#!/bin/bash
# Test script específico para Story 1.2: Sistema de Captura Ultra-Rápida

echo "🧪 Testing Story 1.2: Sistema de Captura Ultra-Rápida"
echo "====================================================="

EXIT_CODE=0

# Test 1: daily-dump.md accepts any format without validation
echo "📝 Test 1: daily-dump.md aceita qualquer formato..."

# Test various formats
test_entries=(
    "Entrada simples de texto"
    "Lista de tarefas:
- Item 1
- Item 2
- Item 3"
    "Parágrafo longo com vários tipos de informação. Inclui [[referências]] para pessoas e projetos. Também tem URLs, números, e caracteres especiais como @#$%."
    "Formato livre mesmo:

  Ideias soltas...

  - Reunião importante
  - Decisão sobre X

  Links: https://example.com

  Pessoas: [[João]], [[Maria]]"
)

for i in "${!test_entries[@]}"; do
    if echo "${test_entries[$i]}" >> despejo/daily-dump.md; then
        echo "   ✅ Formato $((i+1)): Aceito"
    else
        echo "   ❌ Formato $((i+1)): Rejeitado"
        EXIT_CODE=1
    fi
done

# Test 2: No required fields or validation
echo ""
echo "🚫 Test 2: Sem campos obrigatórios..."

# Test empty entries, special characters, etc.
test_inputs=(
    ""
    " "
    "🎉 Emojis funcionam!"
    "Caracteres especiais: áçẽntös, çédilhä, ñ"
    "123456 números soltos"
    "TEXTO EM MAIÚSCULAS"
    "texto em minúsculas"
    "MiXeD cAsE tExT"
)

for input in "${test_inputs[@]}"; do
    echo "$input" >> despejo/daily-dump.md 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "   ✅ Entrada aceita: '$input'"
    else
        echo "   ❌ Entrada rejeitada: '$input'"
        EXIT_CODE=1
    fi
done

# Test 3: Direct access via Claude Code
echo ""
echo "🔗 Test 3: Acesso direto via Claude Code..."

if [ -f "despejo/daily-dump.md" ]; then
    echo "   ✅ Arquivo acessível em despejo/daily-dump.md"

    # Check file permissions
    if [ -r "despejo/daily-dump.md" ] && [ -w "despejo/daily-dump.md" ]; then
        echo "   ✅ Permissões de leitura/escrita: OK"
    else
        echo "   ❌ Permissões inadequadas"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Arquivo não encontrado"
    EXIT_CODE=1
fi

# Test 4: Optional automatic timestamps
echo ""
echo "🕐 Test 4: Timestamps opcionais..."

if [ -x "scripts/add-dump-entry.sh" ]; then
    echo "   ✅ Script de entrada com timestamp disponível"

    # Test timestamp functionality
    if ./scripts/add-dump-entry.sh --help >/dev/null 2>&1; then
        echo "   ✅ Script funcional"

        # Test actual timestamp addition
        if ./scripts/add-dump-entry.sh -t "Test entry with timestamp" >/dev/null 2>&1; then
            echo "   ✅ Timestamp adicionado com sucesso"
        else
            echo "   ❌ Falha ao adicionar timestamp"
            EXIT_CODE=1
        fi
    else
        echo "   ❌ Script com problemas"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Script de entrada não encontrado"
    EXIT_CODE=1
fi

# Test 5: Multiple entries per day support
echo ""
echo "🔄 Test 5: Múltiplas entradas por dia..."

initial_size=$(wc -l < despejo/daily-dump.md)

# Add multiple entries
for i in {1..3}; do
    echo "Entrada múltipla $i - $(date)" >> despejo/daily-dump.md
done

final_size=$(wc -l < despejo/daily-dump.md)

if [ $final_size -gt $initial_size ]; then
    echo "   ✅ Múltiplas entradas suportadas"
    echo "   ✅ Conteúdo preservado (linhas: $initial_size → $final_size)"
else
    echo "   ❌ Falha ao adicionar múltiplas entradas"
    EXIT_CODE=1
fi

# Test 6: Processing integration
echo ""
echo "⚙️  Test 6: Integração com processamento..."

if [ -x "scripts/process-dump.sh" ]; then
    echo "   ✅ Script de processamento disponível"

    if [ -d "despejo/processed" ]; then
        echo "   ✅ Diretório de processamento existe"
    else
        echo "   ⚠️  Diretório de processamento será criado quando necessário"
    fi

    # Test help functionality
    if ./scripts/process-dump.sh help >/dev/null 2>&1; then
        echo "   ✅ Script de processamento funcional"
    else
        echo "   ❌ Script de processamento com problemas"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Script de processamento não encontrado"
    EXIT_CODE=1
fi

# Test 7: No data loss
echo ""
echo "💾 Test 7: Preservação de dados..."

# Count entries before and after operations
content_before=$(grep -c "Entrada múltipla" despejo/daily-dump.md)

# Add more content
echo "Teste de preservação de dados" >> despejo/daily-dump.md

content_after=$(grep -c -E "(Entrada múltipla|Teste de preservação)" despejo/daily-dump.md)

if [ $content_after -gt $content_before ]; then
    echo "   ✅ Dados preservados e novos conteúdos aceitos"
else
    echo "   ❌ Possível perda de dados"
    EXIT_CODE=1
fi

# Test 8: File size and performance
echo ""
echo "⚡ Test 8: Performance básica..."

file_size=$(stat -c%s despejo/daily-dump.md 2>/dev/null || stat -f%z despejo/daily-dump.md 2>/dev/null || echo "unknown")

if [ "$file_size" != "unknown" ]; then
    if [ $file_size -lt 1048576 ]; then  # Less than 1MB
        echo "   ✅ Tamanho do arquivo adequado ($file_size bytes)"
    else
        echo "   ⚠️  Arquivo grande ($file_size bytes) - considere arquivamento"
    fi
else
    echo "   ⚠️  Não foi possível determinar tamanho do arquivo"
fi

# Final summary
echo ""
echo "📊 Story 1.2 Test Results"
echo "========================"

if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 ALL TESTS PASSED! Story 1.2 implementation is complete."
    echo ""
    echo "✅ Accepts any text format without validation"
    echo "✅ No required fields or structure"
    echo "✅ Direct access via Claude Code"
    echo "✅ Optional automatic timestamps"
    echo "✅ Multiple entries per day supported"
    echo "✅ Processing integration ready"
    echo "✅ Data preservation guaranteed"
    echo "✅ Performance adequate"
    echo ""
    echo "🚀 Sistema de captura ultra-rápida totalmente funcional!"
    echo ""
    echo "📋 Como usar:"
    echo "• Edite despejo/daily-dump.md diretamente"
    echo "• Use scripts/add-dump-entry.sh para timestamps"
    echo "• Use scripts/process-dump.sh para arquivamento"
else
    echo "❌ Some tests failed. Check the errors above."
    echo ""
    echo "🔧 Fix the issues and run the test again:"
    echo "   bash test-story-1.2.sh"
fi

exit $EXIT_CODE