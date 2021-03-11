# Generar usuaries iniciales con confirmación, actualiza el password en caso de
# que exista.
#
# Uso:
#
#   rails rananube:db:user[email@ejemplo.com,password]
namespace :rananube do
  namespace :db do
    desc 'Genera un usuarie o actualiza el password'
    task :user, [:email, :password] => :logger do |_, args|
      @user = User.find_or_initialize_by(
        email: args[:email]
      )

      @user.password = args[:password]
      @user.confirm

      if @user.save
        Rails.logger.info "Usuarie #{args[:email]} creado"
      else
        Rails.logger.error 'No se pudo crear este usuarie.'
      end
    end
  end
end
