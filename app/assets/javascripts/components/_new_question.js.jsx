var NewQuestion = React.createClass({
    getInitialState() {
        return {content: '', answer: ''};
    },
    handleClick() {
        var content = this.state.content;
        var answer = this.state.answer;
        $.ajax({
            url: '/api/v1/questions',
            type: 'POST',
            data: {question: {content: content, answer: answer}},
            success: (question) => {
                this.props.handleSubmit(question);
            }
        });
    },
    handleContentChange(e) {
        this.setState({content: e.target.value})
    },
    handleAnswerChange(e) {
        this.setState({answer: e.target.value})
    },

    render() {
        var FormGroup = ReactBootstrap.FormGroup;
        var FormControl = ReactBootstrap.FormControl;
        var Form = ReactBootstrap.Form;
        var Col = ReactBootstrap.Col;
        var ControlLabel = ReactBootstrap.ControlLabel;
        var Button = ReactBootstrap.Button;

        return (
            <div style={{marginTop: 40, marginBottom: 40}}>
                <Form horizontal>
                    <FormGroup controlId="formQuestion">
                        <Col componentClass={ControlLabel} sm={1}>
                            Question
                        </Col>
                        <Col sm={6}>
                            <FormControl ref="content" value={this.state.content} onChange={this.handleContentChange}
                                         type="text" placeholder="Enter the Question"/>
                        </Col>
                    </FormGroup>
                    <FormGroup controlId="formAnswer">
                        <Col componentClass={ControlLabel} sm={1}>
                            Answer
                        </Col>
                        <Col sm={6}>
                            <FormControl ref="answer" value={this.state.answer} onChange={this.handleAnswerChange}
                                         type="text" placeholder="Enter the Answer"/>
                        </Col>
                    </FormGroup>
                    <FormGroup controlId="formAnswer">
                        <Col componentClass={ControlLabel} sm={6}/>
                        <Col sm={1}>
                            <Button bsStyle="primary" onClick={this.handleClick}>Create</Button>
                        </Col>
                    </FormGroup>
                </Form>
            </div>

        )
    }
});