var BodyQuestions = React.createClass({
    getInitialState() {
        return {questions: []}
    },

    componentDidMount() {
        $.getJSON('/api/v1/questions.json', (response) => {
            this.setState({questions: response})
        });
    },


    handleSubmit(question) {
        var newState = [question].concat(this.state.questions);
        this.setState({questions: newState})
    },


    handleDelete(id) {
        $.ajax({
            url: `/api/v1/questions/${id}`,
            type: 'DELETE',
            success: () => {
                this.removeQuestionClient(id);
            }
        });
    },

    removeQuestionClient(id) {
        var newQuestions = this.state.questions.filter((question) => {
            return question.id != id;
        });

        this.setState({questions: newQuestions});
    },


    handleUpdate(question, index) {
        $.ajax({
                url: `/api/v1/questions/${question.id}`,
                type: 'PUT',
                data: {question: question},
                success: () => {
                    this.updateQuestions(question, index);

                }
            }
        )
    },

    updateQuestions(question, index) {
        this.state.questions[index] = question;
        this.setState({questions: this.state.questions});
    },

    render() {
        return (
            <div>
                <NewQuestion handleSubmit={this.handleSubmit}/>
                <AllQuestions questions={this.state.questions} handleDelete={this.handleDelete}
                              onUpdate={this.handleUpdate}/>

            </div>
        )
    }
});