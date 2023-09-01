# frozen_string_literal: true

# Contêm todas as configs necessárias para rodar o projeto
class Wizard
  MESSAGES = [
    'Criando containers', 'Gerando Banco de Dados', 'Startando aplicação', 'Finalizado!'
  ].freeze

  LARGER_MSG = MESSAGES.max do |a, b|
    next -1 if a > b
    next 0 if a < b

    1
  end

  MARGIN = LARGER_MSG.size + 41

  def self.show_splash
    puts File.open('./bin/car.txt').read
  end

  def self.run_containers_generate
    puts MESSAGES.first.center(MARGIN, '=')
    start = Time.now

    `docker-compose build web`
    `sleep 2`
    `docker-compose build mongodb`
    `sleep 2`
    `docker-compose build mongo-express`
    `sleep 2`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_database_generate
    puts MESSAGES[1].center(MARGIN, '=')
    start = Time.now

    `docker-compose up -d mongodb`
    `sleep 2`
    `docker-compose up -d mongo-express`
    `sleep 2`
    final = Time.now
    display_time_to_process(final, start)
  end

  def self.start_application
    puts MESSAGES[2].center(MARGIN, '=')
    start = Time.now

    `docker-compose up -d web`
    `sleep 2`
    `clear`
    `docker-compose up`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_closure
    puts MESSAGES.last.center(MARGIN, '=')
  end

  def self.display_time_to_process(final, start)
    puts "Etapa concluida em (#{(final - start).round(2)} s)\n\n"
  end
end
