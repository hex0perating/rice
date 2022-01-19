// https://www.mickaelvieira.com/blog/2020/06/12/downloading-and-decompressing-a-zip-file-with-deno.html

let BASE_PACMAN_PACKAGES = "bspwm polybar zsh kitty"

/**
 * Download the source file and write it into the destination
 */
 async function download(source, destination) {
    // We use browser fetch API
    const response = await fetch(source);
    const blob = await response.blob();
  
    // We convert the blob into a typed array
    // so we can use it to write the data into the file
    const buf = await blob.arrayBuffer();
    const data = new Uint8Array(buf);
  
    // We then create a new file and write into it
    const file = await Deno.create(destination);
    await Deno.writeAll(file, data);
  
    // We can finally close the file
    Deno.close(file.rid);
}

/**
 * Unzip the file
 */
 async function unzip(filepath, dir) {
    // We execute the command
    // The function returns details about the spawned process
    const process = Deno.run({
      cmd: ["unzip", filepath, "-d", dir],
      stdout: "piped",
      stderr: "piped",
    });
  
    // We can access the status of the process
    const { success, code } = await process.status();
  
    if (!success) {
      // We retrieve the error
      const raw = await process.stderrOutput();
      const str = new TextDecoder().decode(raw);
      throw new Error(`$Command failed: code ${code}, message: ${str}`);
    } else {
      // Similarly to access the command output
      const raw = await process.output();
      const str = new TextDecoder().decode(raw);
    }
  }

async function main() {
    pkgApi.runShell("rm -rf /tmp/rice")
    await download(server + "zip/rice.zip", "/tmp/rice.zip");
    await unzip("/tmp/rice.zip", "/tmp/rice");
    pkgApi.runShell("cp -R /tmp/rice/ /home/" + Deno.env.get("USER"));
    pkgApi.runShell("cp -R /tmp/rice/.config /home/" + Deno.env.get("USER"));
    pkgApi.runShell("cp -R /tmp/rice/.zshrc /home/" + Deno.env.get("USER"));
    pkgApi.runShell("rm -rf ~/hexpkg.json");
    pkgApi.runShell("rm -rf ~/index.js");
    pkgApi.runShell("rm -rf ~/LICENSE");
    pkgApi.runShell("rm -rf ~/README.md");
    await Deno.writeTextFile("/tmp/starship_installer", `#!/bin/bash\nsh -c "$(curl -fsSL https://starship.rs/install.sh)"\nsudo pacman -S ${BASE_PACMAN_PACKAGES}`);
    await pkgApi.runShell("chmod +x /tmp/starship_installer");
    await pkgApi.runShell("/tmp/starship_installer");
    await pkgApi.runShell("rm -rf /tmp/starship_installer");
    console.log("Installation complete!");
}

main()