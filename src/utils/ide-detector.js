const fs = require('fs-extra');
const { exec } = require('child_process');
const os = require('os');
const path = require('path');

/**
 * IDE Detector
 * Detects which IDEs are installed (Claude Code, Cursor)
 */
class IDEDetector {
  /**
   * Detect which IDEs are installed
   * @returns {Object} {claudeCode: boolean, cursor: boolean}
   */
  async detectInstalledIDEs() {
    const ides = {
      claudeCode: await this.isClaudeCodeInstalled(),
      cursor: await this.isCursorInstalled()
    };

    return ides;
  }

  /**
   * Check if Claude Code is installed
   * @returns {boolean}
   */
  async isClaudeCodeInstalled() {
    try {
      // Check if command exists
      return new Promise((resolve) => {
        exec('claude-code --version', { timeout: 3000 }, (error) => {
          resolve(!error);
        });
      });
    } catch {
      return false;
    }
  }

  /**
   * Check if Cursor is installed
   * @returns {boolean}
   */
  async isCursorInstalled() {
    const platform = os.platform();

    try {
      if (platform === 'darwin') {
        // macOS
        return await fs.pathExists('/Applications/Cursor.app');
      } else if (platform === 'win32') {
        // Windows - check multiple possible locations
        const locations = [
          path.join(process.env.LOCALAPPDATA || '', 'Programs', 'cursor'),
          path.join(process.env.APPDATA || '', 'Cursor'),
          'C:\\Program Files\\Cursor'
        ];

        for (const location of locations) {
          if (await fs.pathExists(location)) {
            return true;
          }
        }

        // Try command line
        return new Promise((resolve) => {
          exec('cursor --version', { timeout: 3000 }, (error) => {
            resolve(!error);
          });
        });
      } else {
        // Linux
        return new Promise((resolve) => {
          exec('which cursor', { timeout: 3000 }, (error) => {
            resolve(!error);
          });
        });
      }
    } catch {
      return false;
    }
  }

  /**
   * Get list of available IDEs with labels for UI
   * @returns {Array} Array of {name, value, checked} objects
   */
  async getAvailableIDEs() {
    const installed = await this.detectInstalledIDEs();
    const options = [];

    if (installed.claudeCode) {
      options.push({
        name: 'Claude Code (Anthropic) - detectado',
        value: 'claude-code',
        checked: true
      });
    } else {
      options.push({
        name: 'Claude Code (Anthropic) - manual',
        value: 'claude-code',
        checked: false
      });
    }

    if (installed.cursor) {
      options.push({
        name: 'Cursor (VS Code-based) - detectado',
        value: 'cursor',
        checked: true
      });
    } else {
      options.push({
        name: 'Cursor (VS Code-based) - manual',
        value: 'cursor',
        checked: false
      });
    }

    return options;
  }

  /**
   * Get installation instructions for an IDE
   * @param {string} ideId - IDE identifier (claude-code|cursor)
   * @returns {string} Installation instructions
   */
  getInstallationInstructions(ideId) {
    const instructions = {
      'claude-code': `
Claude Code pode ser baixado em:
https://docs.claude.com/en/docs/claude-code

Instale e depois rode novamente este instalador.
      `.trim(),
      'cursor': `
Cursor pode ser baixado em:
https://cursor.com

Instale e depois rode novamente este instalador.
      `.trim()
    };

    return instructions[ideId] || 'IDE não reconhecido';
  }
}

module.exports = IDEDetector;
