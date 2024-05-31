# Desafio Técnico Landetech

## Configurando o sistema
Para configurar o sistema no seu computador você precisa do ruby configurado no seu computador.

<table>
	<tr>
		<td>Ruby version</td>
		<td>
			2.7.2
		</td>
	</tr>
	<tr>
		<td>Rails version</td>
		<td>
			6.0.0
		</td>
	</tr>
	<tr>
		<td>Database</td>
		<td>
			PostgreSQL
		</td>
	</tr>
</table>

## Configuração

```bash

# installation of dependencies
bundle install
rails db:create
rails db:migrate

# run the project
rails s
```
## Projeto Recruiter

## Registrar Recruiter(Register)
POST `http://localhost:3000/api/v1/register`
```bash
{
	"name": "admin",
	"email": "admin@admin.com",
	"password": "1234567890",
	"password_confirmation": "1234567890"
}
```

## Acesso Recruiter(Login)
POST `http://localhost:3000/api/v1/login`
```bash
{
	"email": "admin@admin.com",
	"password": "1234567890",
}
```
## Token
Após receber o token, adicione-o em `Authorization`  -> `Bearer Token`

## JOBS
## Acesso JOBS
Get `http://localhost:3000/api/v1/jobs`

## Criar JOBS
POST `http://localhost:3000/api/v1/jobs`

```bash
{
    "title": "Software Engineer 2",
    "description": "Develop and maintain software.",
    "start_date": "2024-01-01",
    "end_date": "2024-12-31",
    "skills": "Ruby, Rails, JavaScript"
  }
```

## Visualizar JOBS espeficico(ID)
Get `http://localhost:3000/api/v1/jobs/1`

## Atualizar JOBS espeficico(ID)
PATCH `http://localhost:3000/api/v1/jobs/1`

```bash
{
    "title": "Software"
  }
```
## Deletar JOBS espeficico(ID)
DELETE `http://localhost:3000/api/v1/jobs/1`

## SUBMISSIONS
## Acesso SUBMISSIONS
Get `http://localhost:3000/api/v1/recruiters`

## Criar SUBMISSIONS
POST `http://localhost:3000/api/v1/recruiters`

```bash
{
    "name": "João da Silva",
    "email": "joao@example.com",
    "mobile_phone": "123456789",
    "resume": "Link para o currículo",
    "job_id": 1
  }
```

## Visualizar SUBMISSIONS espeficico(ID)
Get `http://localhost:3000/api/v1/recruiters/2`

## Atualizar SUBMISSIONS espeficico(ID)
PATCH `http://localhost:3000/api/v1/recruiters/2`

```bash
{
    "job_id": 2
  }
```
## Deletar SUBMISSIONS espeficico(ID)
DELETE `http://localhost:3000/api/v1/recruiters/2`


## RECRUITERS
## Acesso RECRUITERS
Get `http://localhost:3000/api/v1/recruiters`

## Criar RECRUITERS
POST `http://localhost:3000/api/v1/recruiters`

```bash
{
    "name": "User",
    "email": "user@user.com",
    "password": "1234567890",
    "password_confirmation": "1234567890"
}
```

## Visualizar RECRUITERS espeficico(ID)
Get `http://localhost:3000/api/v1/recruiters/2`

## Atualizar RECRUITERS espeficico(ID)
PATCH `http://localhost:3000/api/v1/recruiters/2`

```bash
{
    "name": "User Update"
  }
```
## Deletar RECRUITERS espeficico(ID)
DELETE `http://localhost:3000/api/v1/recruiters/2`


## Projeto Publico

BaseUrl: `http://localhost:3000`.
* Para acessar a API, você pode utilizar programas como o Postman, Restfox, Insomnia, entre outros.


## Acesso JOBS
Get `http://localhost:3000/jobs`


## Acesso JOBS espeficico(ID)
Get `http://localhost:3000/jobs/:id`

ou

Get `http://localhost:3000/jobs/1`

## Criar um submission no JOB
POST `http://localhost:3000/jobs`

```bash
{
	"name": "Jonhy Test",
	"email": "test@example.com",
	"mobile_phone": "123456789",
	"resume": "Lorem ipslum..."
}
```

## Tests

To run the tests:

```bash
bundle exec rspec