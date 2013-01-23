class FPM::Package::Zip < FPM::Package
  def input(input_path)
    args = [input_path, "-d", build_path]
    safesystem("unzip", *args)

    dir = convert(FPM::Package::Dir)
    if attributes[:chdir]
      dir.attributes[:chdir] = File.join(build_path, attributes[:chdir])
    else
      dir.attributes[:chdir] = build_path
    end

    cleanup_staging
    dir.input(".")
    @staging_path = dir.staging_path
    dir.cleanup_build
  end
end
