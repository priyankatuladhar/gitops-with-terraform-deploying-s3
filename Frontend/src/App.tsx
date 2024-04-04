import { useEffect, useState } from 'react';
import './App.css';
import axios from 'axios';


interface TodoInterface{
  id: number;
  name:string;
  isCompleted: Boolean;
}
function App() {
  const [todo,setTodo]=useState<TodoInterface[]>([]);
  const [todoName, setTodoName] = useState<string>('')
  const [editModeId, setEditModeId] = useState<number | null>(null);
  

    const getTodos = async () => {
      const {data: { data }
      } = await axios.get('http://localhost:3000/todo');
      setTodo(data);
    };
    useEffect(() => {
    getTodos();
  }, []);
  
  const addTodo = async (e: React.MouseEvent) => {
    e.preventDefault();
    const {data: { data }} = await axios.post('http://localhost:3000/todo',{
      todoName
    });
    getTodos();
    setTodo([...todo, ...data]);
    setTodoName('');
  }

  const deleteTodo = async (id: number) => {
    await axios.delete(`http://localhost:3000/todo/${id}`);
    getTodos();
  };

  const updateTodo = async (id: number, name: string) => {
    await axios.put(`http://localhost:3000/todo/${id}`, {
      name
    });
    getTodos();
    setEditModeId(null); // Exit edit mode after updating
  };

   return (
    <>
    <h1>To Do</h1>
      {todo.map((tod) => (
        <div key={tod.id} className="todo-item">
          {editModeId === tod.id ? (
            <>
              <input
                type='text'
                value={tod.name}
                onChange={(e) => setTodoName(e.target.value)}
              />
              <button onClick={() => updateTodo(tod.id, todoName)}>Save</button>
            </>
          ) : (
            <>
              {tod.name}
              <span className="to-do-right"></span>
              <button className="btn-edit" onClick={() => setEditModeId(tod.id)}>Edit</button>
              <button className="btn-delete" onClick={() => deleteTodo(tod.id)}>Delete</button>
            </>
          )}
        </div>
      ))}
      <input
        type='text'
        value={todoName}
        onChange={(e) => setTodoName(e.target.value)}
        name='todo'
        id='todo'
        style={{ backgroundColor: 'lavenderblush', color: '#333', padding: '8px', borderRadius: '5px', border: '1px solid #ccc', width: '300px' }}
      />
      <button onClick={addTodo}>Add To do</button>
    </>
  );
}
export default App;
