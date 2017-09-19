# encoding: utf-8

##
# Backup Generated: mysqldump
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mysqldump [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:mysqldump, 'MySQL backup for Redmine') do

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = "redmine_development"
    db.username           = "redmine"
    db.password           = "redmine"
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    #db.skip_tables        = ["skip", "these", "tables"]
    #db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
  end

  ##
  # Rackspace Cloud Files [Storage]
  #
  store_with CloudFiles do |cf|
    cf.api_key            = '2a68e340b087135c1548942f00a879d6'
    cf.username           = 'cloud1000197ts'
    cf.container          = 'redmine-production-dbbackup'
    cf.segments_container = 'redmine-production-dbbackup-segments' # must be different than `container`
    cf.segment_size       = 5 # MiB
    cf.path               = '' # path within the container
  end

  ##
  # Rackspace Cloud Files [Syncer]
  #
  #sync_with Cloud::CloudFiles do |cf|
  #  cf.api_key            = '2a68e340b087135c1548942f00a879d6'
  #  cf.username           = 'cloud1000197ts'
  #  cf.container          = 'redmine-production-dbbackup'
  #  cf.path              = "mysqldump"
  #  cf.mirror            = true
  #  cf.thread_count      = 10

  #  cf.directories do |directory|
  #    directory.add "~/code/archstream/db-back/redmine"

      # Exclude files/folders from the sync.
      # The pattern may be a shell glob pattern (see `File.fnmatch`) or a Regexp.
      # All patterns will be applied when traversing each added directory.
  #    directory.exclude '**/*~'
  #    directory.exclude /\/tmp$/
  #  end
  #end

  ##
  # OpenSSL [Encryptor]
  #
  #
  encrypt_with OpenSSL do |encryption|
    encryption.password_file = '/Users/Don/code/archstream/redmine/backup_ctl/pwdfile'
    encryption.base64        = true
    encryption.salt          = true
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "backup@townsquarecommerce.com"
    mail.to                   = "donlivingston@townsquarecommerce.com"
    #mail.cc                   = "cc@email.com"
    #mail.bcc                  = "bcc@email.com"
    #mail.reply_to             = "reply_to@email.com"
    mail.address              = "smtp.sendgrid.net"
    mail.port                 = 587
    mail.domain               = "seizethedeal.com"
    mail.user_name            = "seizethedeal@seizethedeal.com"
    mail.password             = "T7BEqq0Y"
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

end
