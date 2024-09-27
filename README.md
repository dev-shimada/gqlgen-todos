# gqlgen-todos
- https://gqlgen.com/getting-started/

## Run server
```console
go run server.go
```

## Browser tool
- http://localhost:8080

## Creating todo
```graphql
mutation createTodo {
  createTodo(input: { text: "todo", userId: "1" }) {
    user {
      id
    }
    text
    done
  }
}
```

## Query todo
```graphql
query findTodos {
  todos {
    text
    done
    user {
      name
    }
  }
}
```
