{lib, ...}: {
  options.meta.user = lib.mkOption {
    type = lib.types.str;
    description = "The account every host and home is built for.";
  };

  config.meta.user = "marcus";
}
