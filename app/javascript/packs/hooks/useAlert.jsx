import React, { useReducer, useCallback, useContext } from "react";
import { Alert, Container } from "react-bootstrap";

const AlertContext = React.createContext({ alerts: [], dispatch: () => {} });

const AlertContextProvider = (props) => {
  const [alerts, dispatch] = useReducer((state, { type, payload }) => {
    switch (type) {
      case "ADD":
        const id = new Date().valueOf();
        setTimeout(
          () => dispatch({ type: "DELETE", payload: { id } }),
          payload.timeout
        );
        return [...state, { id, ...payload }];

      case "DELETE":
        return state.filter((alert) => alert.id !== payload.id);

      default:
        throw new Exception(`Unknown type "${type}"`);
    }
  }, []);

  return (
    <AlertContext.Provider value={{ alerts, dispatch }}>
      {props.children}
    </AlertContext.Provider>
  );
};

const AlertOutlet = () => (
  <AlertContext.Consumer>
    {({ alerts }) => (
      <Container
        className="position-fixed top-0 start-0 mt-2"
        style={{ zindex: 1080 }}
      >
        {alerts?.map(({ id, message, type }) => (
          <Alert key={id} variant={type}>
            {message}
          </Alert>
        ))}
      </Container>
    )}
  </AlertContext.Consumer>
);

export { AlertContextProvider, AlertOutlet };

export default () => {
  const { dispatch } = useContext(AlertContext);

  return {
    success: useCallback((message) => {
      dispatch({
        type: "ADD",
        payload: { type: "success", message, timeout: 2000 },
      });
    }),
    danger: useCallback((message) => {
      dispatch({
        type: "ADD",
        payload: { type: "danger", message, timeout: 30000 },
      });
    }),
  };
};
