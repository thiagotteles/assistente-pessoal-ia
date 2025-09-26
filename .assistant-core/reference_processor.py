#!/usr/bin/env python3
"""
Reference Processor for Assistente Pessoal IA
Handles automatic [[reference]] detection, linking, and cross-referencing
Integrates with Knowledge-Base Manager for intelligent information management
"""

import os
import re
import sys
import yaml
from typing import Dict, List, Set, Tuple, Optional
from pathlib import Path
from datetime import datetime

# Add current directory to path for imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

class ReferenceProcessor:
    """Processes and manages [[references]] in markdown files"""

    def __init__(self, project_root: str = None):
        self.project_root = Path(project_root) if project_root else Path(__file__).parent.parent
        self.knowledge_base_path = self.project_root / "knowledge-base"

        # Reference patterns
        self.reference_pattern = re.compile(r'\[\[([^\]]+)\]\]')
        self.people_pattern = re.compile(r'\b([A-Z][a-z]+ [A-Z][a-z]+)\b')  # João Silva format
        self.project_pattern = re.compile(r'\b(Projeto [A-Z][a-z]+|Sistema [A-Z][a-z]+|[A-Z][a-z]+ Project)\b')

        # Knowledge categories
        self.categories = {
            "pessoas": self.knowledge_base_path / "pessoas",
            "projetos": self.knowledge_base_path / "projetos",
            "decisoes": self.knowledge_base_path / "decisoes",
            "contextos": self.knowledge_base_path / "contextos"
        }

        # Create directories if they don't exist
        for category_path in self.categories.values():
            category_path.mkdir(parents=True, exist_ok=True)

        # Reference database
        self.known_references = self._build_reference_database()

    def _build_reference_database(self) -> Dict[str, Dict]:
        """Build database of known references from existing files"""
        references = {}

        for category, path in self.categories.items():
            if path.exists():
                for md_file in path.glob("*.md"):
                    # Extract reference name from filename
                    name = md_file.stem.replace("-", " ").title()
                    references[name] = {
                        "category": category,
                        "file": md_file,
                        "created": datetime.fromtimestamp(md_file.stat().st_ctime),
                        "title": name
                    }

        return references

    def detect_references_in_text(self, text: str) -> Dict[str, List[str]]:
        """Detect all types of references in text"""
        detected = {
            "explicit": [],      # [[Reference]] format
            "people": [],        # João Silva format
            "projects": [],      # Project Alpha format
            "concepts": []       # Other detectable concepts
        }

        # Detect explicit [[references]]
        explicit_refs = self.reference_pattern.findall(text)
        detected["explicit"] = list(set(explicit_refs))

        # Detect people names (excluding those already in [[]])
        text_without_refs = self.reference_pattern.sub("", text)
        people = self.people_pattern.findall(text_without_refs)
        detected["people"] = list(set(people))

        # Detect project names
        projects = self.project_pattern.findall(text_without_refs)
        detected["projects"] = list(set(projects))

        # Detect concepts (simple heuristic)
        concept_patterns = [
            r'\b([A-Z][a-z]+ [A-Z][a-z]+(?:ção|mento|agem|ncia))\b',  # Portuguese technical terms
            r'\b(API [A-Z][a-z]+|[A-Z][a-z]+ API)\b',  # API references
            r'\b([A-Z][a-z]+Script|[A-Z][a-z]+SQL)\b'   # Technology references
        ]

        for pattern in concept_patterns:
            concepts = re.findall(pattern, text_without_refs)
            detected["concepts"].extend(concepts)

        detected["concepts"] = list(set(detected["concepts"]))

        return detected

    def auto_link_text(self, text: str, source_file: str = None) -> str:
        """Automatically add [[]] links to detected references"""
        modified_text = text

        # Get detected references
        references = self.detect_references_in_text(text)

        # Process people
        for person in references["people"]:
            # Only link if not already linked
            if f"[[{person}]]" not in modified_text:
                # Replace first occurrence (to avoid over-linking)
                pattern = re.compile(r'\b' + re.escape(person) + r'\b')
                modified_text = pattern.sub(f"[[{person}]]", modified_text, count=1)

        # Process projects
        for project in references["projects"]:
            if f"[[{project}]]" not in modified_text:
                pattern = re.compile(r'\b' + re.escape(project) + r'\b')
                modified_text = pattern.sub(f"[[{project}]]", modified_text, count=1)

        # Process concepts
        for concept in references["concepts"]:
            if f"[[{concept}]]" not in modified_text:
                pattern = re.compile(r'\b' + re.escape(concept) + r'\b')
                modified_text = pattern.sub(f"[[{concept}]]", modified_text, count=1)

        return modified_text

    def create_reference_file(self, reference: str, category: str = None, content: str = None) -> Path:
        """Create a new reference file if it doesn't exist"""

        # Determine category if not specified
        if category is None:
            if self.people_pattern.match(reference):
                category = "pessoas"
            elif self.project_pattern.match(reference):
                category = "projetos"
            else:
                category = "contextos"

        # Create filename
        filename = reference.lower().replace(" ", "-") + ".md"
        file_path = self.categories[category] / filename

        # Don't overwrite existing files
        if file_path.exists():
            return file_path

        # Generate content if not provided
        if content is None:
            content = self._generate_reference_template(reference, category)

        # Write file
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)

        # Update reference database
        self.known_references[reference] = {
            "category": category,
            "file": file_path,
            "created": datetime.now(),
            "title": reference
        }

        return file_path

    def _generate_reference_template(self, reference: str, category: str) -> str:
        """Generate template content for new reference files"""
        timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")

        templates = {
            "pessoas": f"""# {reference}

**Tipo**: Pessoa
**Criado**: {timestamp}
**Tags**: #pessoa

## Informações Básicas

- **Nome**: {reference}
- **Cargo**:
- **Empresa**:
- **Especialidades**:
- **Contato**:

## Projetos Relacionados

## Histórico de Interações

### {datetime.now().strftime("%Y-%m-%d")} - Primeira menção
- Referenciado em contexto de sistema

## Notas

""",

            "projetos": f"""# {reference}

**Tipo**: Projeto
**Status**:
**Criado**: {timestamp}
**Tags**: #projeto

## Visão Geral

## Time Principal

## Tecnologias

## Marcos Importantes

### {datetime.now().strftime("%Y-%m-%d")} - Criação do projeto
- Projeto criado automaticamente

## Decisões Técnicas

## Próximos Passos

""",

            "contextos": f"""# {reference}

**Tipo**: Contexto
**Criado**: {timestamp}
**Tags**: #contexto

## Descrição

## Informações Relacionadas

## Referências

""",

            "decisoes": f"""# {reference}

**Tipo**: Decisão
**Data**: {timestamp}
**Status**: Proposta
**Tags**: #decisao

## Contexto

## Decisão

## Razões

## Impactos

## Pessoas Envolvidas

## Próximos Passos

"""
        }

        return templates.get(category, templates["contextos"])

    def process_file_references(self, file_path: Path) -> Dict[str, any]:
        """Process all references in a file and create missing reference files"""
        if not file_path.exists():
            return {"error": "File not found"}

        # Read file content
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Detect references
        references = self.detect_references_in_text(content)

        # Auto-link content
        auto_linked_content = self.auto_link_text(content, str(file_path))

        # Create missing reference files
        created_files = []
        all_refs = (references["explicit"] + references["people"] +
                   references["projects"] + references["concepts"])

        for ref in set(all_refs):
            if ref not in self.known_references:
                created_file = self.create_reference_file(ref)
                created_files.append(created_file)

        # Update file with auto-linked content if changed
        if auto_linked_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(auto_linked_content)

        return {
            "processed_file": file_path,
            "references_detected": references,
            "created_files": created_files,
            "auto_linked": auto_linked_content != content,
            "total_references": len(all_refs)
        }

    def check_file_size_and_split(self, file_path: Path, max_lines: int = 2000) -> Dict[str, any]:
        """Check file size and split if necessary"""
        if not file_path.exists():
            return {"error": "File not found"}

        # Count lines
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        if len(lines) <= max_lines:
            return {"split_needed": False, "line_count": len(lines)}

        # File needs splitting
        return self._split_large_file(file_path, lines)

    def _split_large_file(self, file_path: Path, lines: List[str]) -> Dict[str, any]:
        """Split large file into smaller chunks while preserving references"""
        base_name = file_path.stem
        base_dir = file_path.parent

        # Find natural split points (headers, sections)
        split_points = [0]  # Start of file

        for i, line in enumerate(lines):
            # Split on markdown headers
            if line.strip().startswith('#') and i > 500:  # Don't split too early
                split_points.append(i)

        # Ensure we don't create too large chunks
        if len(split_points) == 1:  # No natural split points found
            # Split every 1500 lines
            for i in range(1500, len(lines), 1500):
                split_points.append(i)

        split_points.append(len(lines))  # End of file

        created_files = []

        for i in range(len(split_points) - 1):
            start = split_points[i]
            end = split_points[i + 1]

            # Create new filename
            new_filename = f"{base_name}-part-{i+1:02d}.md"
            new_file_path = base_dir / new_filename

            # Extract content
            chunk_lines = lines[start:end]

            # Add navigation header
            nav_header = f"""# {base_name.replace('-', ' ').title()} - Parte {i+1}

**Arquivo Original**: [[{base_name}]]
**Navegação**: """

            if i > 0:
                nav_header += f"← [[{base_name}-part-{i:02d}]] | "
            if i < len(split_points) - 2:
                nav_header += f"[[{base_name}-part-{i+2:02d}]] →"

            nav_header += "\n\n---\n\n"

            # Write chunk
            with open(new_file_path, 'w', encoding='utf-8') as f:
                f.write(nav_header)
                f.writelines(chunk_lines)

            created_files.append(new_file_path)

        # Create index file
        index_content = f"""# {base_name.replace('-', ' ').title()} - Índice

**Arquivo dividido em**: {len(created_files)} partes
**Data da divisão**: {datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}

## Partes do arquivo:

"""
        for i, file_path in enumerate(created_files):
            index_content += f"- [[{file_path.stem}|Parte {i+1}]]\n"

        index_file = base_dir / f"{base_name}-index.md"
        with open(index_file, 'w', encoding='utf-8') as f:
            f.write(index_content)

        # Rename original file
        backup_file = base_dir / f"{base_name}-original-backup.md"
        file_path.rename(backup_file)

        return {
            "split_needed": True,
            "original_lines": len(lines),
            "created_files": created_files,
            "index_file": index_file,
            "backup_file": backup_file,
            "split_count": len(created_files)
        }

    def create_cross_reference_timeline(self) -> str:
        """Create timeline of all references and their relationships"""
        timeline = f"# Timeline de Referências\n\n**Gerado em**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"

        # Sort references by creation date
        sorted_refs = sorted(
            self.known_references.items(),
            key=lambda x: x[1].get("created", datetime.min)
        )

        current_date = None

        for ref_name, ref_data in sorted_refs:
            ref_date = ref_data.get("created", datetime.min).strftime("%Y-%m-%d")

            # Add date header if new date
            if ref_date != current_date:
                timeline += f"\n## {ref_date}\n\n"
                current_date = ref_date

            # Add reference entry
            category = ref_data.get("category", "unknown")
            timeline += f"- [[{ref_name}]] ({category})\n"

        return timeline

    def validate_all_references(self) -> Dict[str, List[str]]:
        """Validate all references in the knowledge base"""
        issues = {
            "broken_links": [],
            "orphaned_files": [],
            "missing_references": [],
            "circular_references": []
        }

        # Check all markdown files
        for category_path in self.categories.values():
            if category_path.exists():
                for md_file in category_path.glob("*.md"):
                    # Read file and find references
                    with open(md_file, 'r', encoding='utf-8') as f:
                        content = f.read()

                    refs = self.reference_pattern.findall(content)

                    for ref in refs:
                        # Check if referenced file exists
                        if ref not in self.known_references:
                            issues["missing_references"].append(f"{md_file.name} → {ref}")

        return issues


def main():
    """CLI interface for reference processing"""
    import argparse

    parser = argparse.ArgumentParser(description="Reference Processor for Knowledge Base")
    parser.add_argument("command", choices=["process", "split", "timeline", "validate"])
    parser.add_argument("--file", help="File to process")
    parser.add_argument("--max-lines", type=int, default=2000, help="Max lines before splitting")
    parser.add_argument("--project-root", help="Project root directory")

    args = parser.parse_args()

    # Initialize processor
    processor = ReferenceProcessor(args.project_root)

    if args.command == "process":
        if not args.file:
            print("Error: --file required for process command")
            sys.exit(1)

        file_path = Path(args.file)
        result = processor.process_file_references(file_path)
        print(f"Processed: {result}")

    elif args.command == "split":
        if not args.file:
            print("Error: --file required for split command")
            sys.exit(1)

        file_path = Path(args.file)
        result = processor.check_file_size_and_split(file_path, args.max_lines)
        print(f"Split result: {result}")

    elif args.command == "timeline":
        timeline = processor.create_cross_reference_timeline()
        timeline_file = processor.knowledge_base_path / "timeline-referencias.md"
        with open(timeline_file, 'w', encoding='utf-8') as f:
            f.write(timeline)
        print(f"Timeline created: {timeline_file}")

    elif args.command == "validate":
        issues = processor.validate_all_references()
        print("Validation results:")
        for issue_type, items in issues.items():
            print(f"  {issue_type}: {len(items)} issues")
            for item in items[:5]:  # Show first 5
                print(f"    - {item}")


if __name__ == "__main__":
    main()