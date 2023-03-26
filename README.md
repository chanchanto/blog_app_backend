This is an api-only rails app for CRUD posts, comments and bookmarks. 

[API doc](https://backendapi.osc-fr1.scalingo.io/api-docs/index.html) | [Frontend](https://github.com/chanchanto/blog_app_frontend)

## Dependencies
- Ruby 3.2.0
- Rails 7.0.4.2
- PostgreSQL
- [devise](https://github.com/heartcombo/devise)
- [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)
- [active_model_serializers](https://github.com/rails-api/active_model_serializers)
- [rswag](https://github.com/rswag/rswag)

## Database
![ERD](https://user-images.githubusercontent.com/61821744/230223293-774e66c9-9072-4b58-a938-272778d9961c.jpg)

To initialize database, run:
```
$ rails db:create
$ rails db:migrate
```

## Deployment (Scalingo)
1. Sign in to [Scalingo](https://scalingo.com/) (no credit card needed!)
2. Create an application, choose to deploy branch `main`
3. Go to your app dashboard and add addon: PostgreSQL (Sandbox)
4. Add [environment variables](https://doc.scalingo.com/platform/app/environment#ruby): `GOOGLE_OAUTH_CLIENT_ID`, `GOOGLE_OAUTH_CLIENT_SECRET`
5. Deploy your app by going to your dashboard in Deploy/Manual deployment, and click Trigger deployment
 (or you can try [other deploy methods](https://doc.scalingo.com/platform/deployment/deployment-process#deployment-trigger) as well)
6. [Install Scalingo CLI](https://doc.scalingo.com/platform/cli/start) and [Login](https://doc.scalingo.com/platform/cli/introduction#prerequisites)
7. Lastly, from your terminal, run:
```
$ scalingo -a your-app run rails db:migrate
```
replace `your-app` with your app name