var Question = React.createClass({
    getInitialState() {
        return {editable: false}
    },
    handleEdit() {
        if (this.state.editable) {
            var id = this.props.question.id;
            var content = this.refs.content.value;
            var answer = this.refs.answer.value;
            var question = {id: id, content: content, answer: answer};
            this.props.handleUpdate(question);

        }
        this.setState({editable: !this.state.editable})
    },

    render() {
        var content = this.state.editable ?
            <input type='text' ref='content' defaultValue={this.props.question.content}/> :
            <h3>{this.props.question.content}</h3>;
        var answer = this.state.editable ?
            <input type='text' ref='answer' defaultValue={this.props.question.answer}/> :
            <p>{this.props.question.answer}</p>;
        return (
            <div>
                {content}
                {answer}
                <button onClick={this.props.handleDelete}>Delete</button>
                <button onClick={this.handleEdit}> {this.state.editable ? 'Submit' : 'Edit' } </button>
            </div>
        )
    }
});