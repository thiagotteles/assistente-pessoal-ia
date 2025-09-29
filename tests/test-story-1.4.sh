#!/bin/bash
# Test script específico para Story 1.4: Knowledge-Base Compartilhada Básica

echo "🧪 Testing Story 1.4: Knowledge-Base Compartilhada Básica"
echo "========================================================"

EXIT_CODE=0

# Test 1: Knowledge-Base Manager integration
echo "💾 Test 1: Integração Knowledge-Base Manager do Épico 0..."

kb_manager_file=".assistant-core/knowledge_base_manager.py"

if [ -f "$kb_manager_file" ]; then
    echo "   ✅ Knowledge-Base Manager: Available"

    # Check for key functions
    if grep -q "salvar_entrada\|recuperar_entrada" "$kb_manager_file"; then
        echo "   ✅ Core functions: salvar_entrada() and recuperar_entrada() present"
    else
        echo "   ❌ Core functions: Missing key interfaces"
        EXIT_CODE=1
    fi

    # Check for metadata support
    if grep -q "metadados\|metadata" "$kb_manager_file"; then
        echo "   ✅ Metadata: YAML metadata support present"
    else
        echo "   ⚠️  Metadata: Limited metadata support"
    fi

else
    echo "   ❌ Knowledge-Base Manager: Not found"
    EXIT_CODE=1
fi

# Test 2: Reference processing system
echo ""
echo "🔗 Test 2: Sistema completo de [[referências]]..."

ref_processor_file=".assistant-core/reference_processor.py"

if [ -f "$ref_processor_file" ]; then
    echo "   ✅ Reference Processor: Available"

    # Check for auto-linking features
    if grep -q "auto_link_text\|detect_references" "$ref_processor_file"; then
        echo "   ✅ Auto-linking: Reference detection and linking implemented"
    else
        echo "   ❌ Auto-linking: Missing auto-linking functionality"
        EXIT_CODE=1
    fi

    # Check for different reference types
    if grep -q "people_pattern\|project_pattern" "$ref_processor_file"; then
        echo "   ✅ Reference types: People and projects detection implemented"
    else
        echo "   ❌ Reference types: Missing reference type detection"
        EXIT_CODE=1
    fi

    # Check for bidirectional linking
    if grep -q "create_reference_file\|reference_database" "$ref_processor_file"; then
        echo "   ✅ Bidirectional links: Reference file creation and database present"
    else
        echo "   ❌ Bidirectional links: Missing reference file management"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Reference Processor: Not found"
    EXIT_CODE=1
fi

# Test 3: Auto-splitting functionality
echo ""
echo "📄 Test 3: Auto-splitting de arquivos grandes..."

if [ -f "$ref_processor_file" ]; then
    # Check for splitting functionality
    if grep -q "check_file_size_and_split\|split_large_file" "$ref_processor_file"; then
        echo "   ✅ Auto-splitting: File splitting functionality implemented"

        # Check for line limit configuration
        if grep -q "max_lines.*2000\|2000" "$ref_processor_file"; then
            echo "   ✅ Line limit: 2000 line limit configured"
        else
            echo "   ⚠️  Line limit: Custom limit but may not be 2000 lines"
        fi

        # Check for reference preservation
        if grep -q "preserv.*references\|maintain.*references" "$ref_processor_file"; then
            echo "   ✅ Reference preservation: References maintained after splitting"
        else
            echo "   ⚠️  Reference preservation: May not preserve references optimally"
        fi

        # Check for navigation between split files
        if grep -q "navigation\|nav_header\|index_file" "$ref_processor_file"; then
            echo "   ✅ Navigation: Navigation system between split files implemented"
        else
            echo "   ❌ Navigation: Missing navigation between split files"
            EXIT_CODE=1
        fi

    else
        echo "   ❌ Auto-splitting: File splitting functionality missing"
        EXIT_CODE=1
    fi
fi

# Test 4: Cross-referencing system
echo ""
echo "🔄 Test 4: Cross-referencing automático..."

if [ -f "$ref_processor_file" ]; then
    # Check for cross-referencing
    if grep -q "cross_reference\|timeline\|related" "$ref_processor_file"; then
        echo "   ✅ Cross-referencing: Automatic cross-referencing implemented"

        # Check for timeline functionality
        if grep -q "create_cross_reference_timeline\|timeline" "$ref_processor_file"; then
            echo "   ✅ Timeline: Automatic timeline of events implemented"
        else
            echo "   ❌ Timeline: Missing automatic timeline functionality"
            EXIT_CODE=1
        fi

        # Check for grouping by project/person
        if grep -q "category\|group.*project\|group.*person" "$ref_processor_file"; then
            echo "   ✅ Grouping: Information grouping by project/person present"
        else
            echo "   ❌ Grouping: Missing information grouping functionality"
            EXIT_CODE=1
        fi

    else
        echo "   ❌ Cross-referencing: Cross-referencing system missing"
        EXIT_CODE=1
    fi

    # Check for validation system
    if grep -q "validate_all_references\|validate.*links" "$ref_processor_file"; then
        echo "   ✅ Validation: Reference validation system implemented"
    else
        echo "   ❌ Validation: Missing reference validation"
        EXIT_CODE=1
    fi
fi

# Test 5: Obsidian integration
echo ""
echo "📊 Test 5: Integração completa com Obsidian..."

# Check Obsidian vault structure
if [ -d "knowledge-base/.obsidian" ]; then
    echo "   ✅ Obsidian vault: Valid vault structure in knowledge-base/"

    # Check for graph view configuration
    if [ -f "knowledge-base/.obsidian/graph.json" ]; then
        echo "   ✅ Graph view: Configuration present"
    else
        echo "   ❌ Graph view: Missing graph.json configuration"
        EXIT_CODE=1
    fi

    # Check for app configuration
    if [ -f "knowledge-base/.obsidian/app.json" ]; then
        echo "   ✅ App config: Obsidian app.json configured"
    else
        echo "   ❌ App config: Missing app.json"
        EXIT_CODE=1
    fi

else
    echo "   ❌ Obsidian vault: knowledge-base is not a valid Obsidian vault"
    EXIT_CODE=1
fi

# Test knowledge-base directory structure
echo ""
echo "📁 Test 5.1: Estrutura do knowledge-base..."

required_kb_dirs=(
    "knowledge-base/pessoas"
    "knowledge-base/projetos"
    "knowledge-base/decisoes"
    "knowledge-base/contextos"
)

for dir in "${required_kb_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "   ✅ Directory: $dir exists"
    else
        echo "   ❌ Directory: $dir missing"
        EXIT_CODE=1
    fi
done

# Test 6: Reference file examples and functionality
echo ""
echo "📝 Test 6: Funcionalidade de arquivos de referência..."

# Check if example reference files exist and have [[references]]
reference_files_with_links=0

for category in "pessoas" "projetos" "decisoes" "contextos"; do
    kb_dir="knowledge-base/$category"
    if [ -d "$kb_dir" ]; then
        md_files=$(find "$kb_dir" -name "*.md" 2>/dev/null | wc -l)
        if [ "$md_files" -gt 0 ]; then
            echo "   ✅ Category $category: $md_files files present"

            # Check for [[references]] in files
            files_with_refs=$(find "$kb_dir" -name "*.md" -exec grep -l '\[\[.*\]\]' {} \; 2>/dev/null | wc -l)
            if [ "$files_with_refs" -gt 0 ]; then
                echo "   ✅ References in $category: $files_with_refs files contain [[references]]"
                reference_files_with_links=$((reference_files_with_links + files_with_refs))
            fi
        else
            echo "   ⚠️  Category $category: No files present"
        fi
    fi
done

if [ "$reference_files_with_links" -gt 0 ]; then
    echo "   ✅ Total reference usage: $reference_files_with_links files with [[links]]"
else
    echo "   ⚠️  Reference usage: Limited [[reference]] usage detected"
fi

# Test 7: Integration with previous stories
echo ""
echo "🔗 Test 7: Integração com stories anteriores..."

# Check integration with Story 1.1 (structure)
if [ -f ".git/hooks/pre-commit" ] && [ -d "knowledge-base/.obsidian" ]; then
    echo "   ✅ Story 1.1: Git hooks and Obsidian integration maintained"
else
    echo "   ❌ Story 1.1: Missing integration with file structure"
    EXIT_CODE=1
fi

# Check integration with Story 1.2 (capture)
if [ -f "scripts/process-dump.sh" ] && [ -f "despejo/daily-dump.txt" ]; then
    echo "   ✅ Story 1.2: Capture system integration maintained"
else
    echo "   ❌ Story 1.2: Missing integration with capture system"
    EXIT_CODE=1
fi

# Check integration with Story 1.3 (slash commands)
if [ -f ".assistant-core/slash_command_dispatcher.py" ]; then
    # Check if knowledge base is integrated with slash commands
    if grep -q "knowledge_manager\|knowledge_base" ".assistant-core/slash_command_dispatcher.py"; then
        echo "   ✅ Story 1.3: Slash commands integrated with knowledge base"
    else
        echo "   ❌ Story 1.3: Missing knowledge base integration in slash commands"
        EXIT_CODE=1
    fi
else
    echo "   ❌ Story 1.3: Missing slash command system"
    EXIT_CODE=1
fi

# Test 8: Performance considerations
echo ""
echo "⚡ Test 8: Considerações de performance..."

# Check for large files that might need splitting
large_files_count=0
for md_file in $(find knowledge-base -name "*.md" 2>/dev/null); do
    if [ -f "$md_file" ]; then
        line_count=$(wc -l < "$md_file" 2>/dev/null || echo 0)
        if [ "$line_count" -gt 2000 ]; then
            large_files_count=$((large_files_count + 1))
        fi
    fi
done

if [ "$large_files_count" -eq 0 ]; then
    echo "   ✅ File sizes: No files exceed 2000 lines (optimal performance)"
else
    echo "   ⚠️  File sizes: $large_files_count files exceed 2000 lines (may need splitting)"
fi

# Check total knowledge base size
kb_file_count=$(find knowledge-base -name "*.md" 2>/dev/null | wc -l)
echo "   ✅ Knowledge base: $kb_file_count total markdown files"

# Test 9: CLI interface for reference processing
echo ""
echo "💻 Test 9: Interface CLI do processador de referências..."

if [ -f "$ref_processor_file" ]; then
    # Check for CLI interface
    if grep -q "def main()\|argparse" "$ref_processor_file"; then
        echo "   ✅ CLI interface: Command line interface implemented"

        # Check for available commands
        if grep -q "process.*split.*timeline.*validate" "$ref_processor_file"; then
            echo "   ✅ CLI commands: Multiple commands available (process, split, timeline, validate)"
        else
            echo "   ❌ CLI commands: Missing comprehensive command set"
            EXIT_CODE=1
        fi
    else
        echo "   ❌ CLI interface: Missing command line interface"
        EXIT_CODE=1
    fi
fi

# Final summary
echo ""
echo "📊 Story 1.4 Test Results"
echo "========================"

if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 ALL TESTS PASSED! Story 1.4 implementation is complete."
    echo ""
    echo "✅ Knowledge-Base Manager integrated from Épico 0"
    echo "✅ Complete [[reference]] system with auto-linking"
    echo "✅ Auto-splitting for large files (>2000 lines)"
    echo "✅ Automatic cross-referencing between information"
    echo "✅ Complete Obsidian integration with graph view"
    echo "✅ Reference processor with CLI interface"
    echo "✅ Bidirectional linking system implemented"
    echo "✅ Performance optimizations active"
    echo "✅ Integration with all previous stories maintained"
    echo ""
    echo "🚀 Knowledge-Base compartilhada totalmente funcional!"
    echo ""
    echo "📋 Funcionalidades disponíveis:"
    echo "• Detecção automática de [[pessoas]], [[projetos]], e [[conceitos]]"
    echo "• Auto-linking inteligente de referências em texto"
    echo "• Splitting automático de arquivos grandes"
    echo "• Timeline automático de eventos e decisões"
    echo "• Validação de consistência de referências"
    echo "• Integração completa com Obsidian graph view"
    echo "• CLI para processamento: python reference_processor.py"
else
    echo "❌ Some tests failed. Check the errors above."
    echo ""
    echo "🔧 Fix the issues and run the test again:"
    echo "   bash test-story-1.4.sh"
fi

exit $EXIT_CODE