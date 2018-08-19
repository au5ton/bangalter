module Audio
  def Audio.process_file(path:, parsed_options:)

    lossless_formats = [".flac", ".wav", ".aiff"]
    lossy_formats = [".ogg", ".mp3", ".m4a", ".wma"]

    # prints the location of path within the source folder
    if lossless_formats.include? File.extname(path) 
      # transcode the lossless file
    elsif lossy_formats.include? File.extname(path) 
      # no lossy transcodes, copy the lossy file verbatim
    else
      # do nothing
    end

    puts path[options[:source_folder].length..-1]


  end
end