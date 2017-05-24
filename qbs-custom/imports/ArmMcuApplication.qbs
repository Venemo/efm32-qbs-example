import qbs
import qbs.FileInfo

ArmMcuProduct {

    type: ["application", "hex", "bin", "size"]
    cpp.executableSuffix: ".out"

    Rule {
        id: hex
        inputs: ["application"]
        prepare: {
            var args = ["-O", "ihex", input.filePath, output.filePath];
            var cmd = new Command("arm-none-eabi-objcopy", args);
            cmd.description = "converting to hex: " + FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;

        }
        Artifact {
            fileTags: ["hex"]
            filePath: FileInfo.baseName(input.filePath) + ".hex"
        }
    }

    Rule {
        id: bin
        inputs: ["application"]
        prepare: {
            var args = ["-O", "binary", input.filePath, output.filePath];
            var cmd = new Command("arm-none-eabi-objcopy", args);
            cmd.description = "converting to bin: "+ FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;

        }
        Artifact {
            fileTags: ["bin"]
            filePath: FileInfo.baseName(input.filePath) + ".bin"
        }
    }

    Rule {
        id: size
        inputs: ["application"]
        alwaysRun: true
        prepare: {
            var args = [input.filePath];
            var cmd = new Command("arm-none-eabi-size", args);
            cmd.description = "File size: " + FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;
        }
        Artifact {
            fileTags: ["size"]
            filePath: undefined
        }
    }
        
}

