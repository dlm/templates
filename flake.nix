{
  description = "Dave's flake templates";

  outputs =
    { self, ... }:
    {
      templates = {
        flakeify-go= {
          path = ./flakeify-go;
          description = "Add tooling for flakes to a go project";
        };
      };
    };
}
