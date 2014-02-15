

#[-3-]encoding: utf-8
#[-4-]Source code from [https://github.com/thoughtbot/paperclip]
#[-5-]Copyright (c) 2008-2014 Jon Yurek and thoughtbot, inc.
require 'uri'
require 'paperclip/url_generator'
require 'active_support/deprecation'

module Paperclip
  #[-11-]The Attachment class manages the files for a given attachment. It saves
  #[-12-]when the model saves, deletes when the model is destroyed, and processes
  #[-13-]the file upon assignment.
  class Attachment
    #[-15-]What gets called when you call instance.attachment = File. It clears
    #[-16-]errors, assigns attributes, and processes the file. It
    #[-17-]also queues up the previous file for deletion, to be flushed away on
    #[-18-]#save of its host.  In addition to form uploads, you can also assign
=begin
[-20-]another Paperclip attachment:
[-21-]  new_user.avatar = old_user.avatar
[-22-]  new_user.avatar = old_user.avatar
=end
    def assign uploaded_file
      @dirty = true

      post_process(*only_process) if post_processing

      #[-29-]Reset the file size if the original file was reprocessed.
      instance_write(:file_size,   @queued_for_write[:original].size)
      instance_write(:fingerprint, @queued_for_write[:original].fingerprint) if instance_respond_to?(:fingerprint)
      updater = :"#{name}_file_name_will_change!"
      instance.send updater if instance.respond_to? updater
    end
  end
end
