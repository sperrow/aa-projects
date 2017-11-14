import React from 'react';
import uniqueId from '../../util/util';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: '',
      done: false
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  linkState(key) {
    return (event => this.setState({[key]: event.currentTarget.value}));
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.receiveTodo({
      id: uniqueId(),
      title: this.state.title,
      body: this.state.body
    });
    this.setState({
      title: '',
      body: ''
    });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Title: <input type="text" value={this.state.title} onChange={this.linkState('title')}/>
        </label>

        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default TodoForm;
