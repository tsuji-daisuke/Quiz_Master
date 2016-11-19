var AllQuestions = React.createClass({
    handleDelete(id) {
        this.props.handleDelete(id);
    },

    onUpdate(question) {
        this.props.onUpdate(question);
    },

    render() {
        var questions = this.props.questions.map((question) => {
            return (
                <div key={question.id}>
                    <Question question={question}
                              handleDelete={this.handleDelete.bind(this, question.id)}
                              handleUpdate={this.onUpdate}/>
                </div>
            )
        });

        return (
            <div>
                {questions}
            </div>
        )
    }
});