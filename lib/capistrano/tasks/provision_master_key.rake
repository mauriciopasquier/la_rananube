desc 'Sube al server la master.key relevante al entorno en deploy'
namespace :deploy do
  namespace :check do
    before :linked_files, :provision_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/#{fetch(:key_path)} ]")
          upload! fetch(:key_path), "#{shared_path}/#{fetch(:key_path)}"
        end
      end
    end
  end
end
