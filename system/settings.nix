# Contains declarations for options that describe a host.

{
  lib,
  ...
}:

{
  options.settings = {
    # TODO:
    # This should really be an array but I only
    # have a single display so it works for now!
    display = {
      source = lib.mkOption {
        type = lib.types.str;
      };

      resolution = {
        width = lib.mkOption {
          type = lib.types.int;
        };
        height = lib.mkOption {
          type = lib.types.int;
        };
      };

      refreshRate = lib.mkOption {
        type = lib.types.float;
      };

      position = {
        x = lib.mkOption {
          type = lib.types.int;
        };
        y = lib.mkOption {
          type = lib.types.int;
        };
      };

      scale = lib.mkOption {
        type = lib.types.float;
      };
    };
  };
}
