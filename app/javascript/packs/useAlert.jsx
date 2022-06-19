import React, { useId } from "react";
import { useCallback, useContext, useState } from "react";
import { Alert, Container } from "react-bootstrap";

const AlertContext = React.createContext({ alerts: [], setAlerts: () => {} });

const AlertContextProvider = (props) => {
  const [alerts, setAlerts] = useState([]);

  return (
    <AlertContext.Provider value={{ alerts, setAlerts }}>
      {props.children}
    </AlertContext.Provider>
  );
};

const AlertOutlet = () => (
  <AlertContext.Consumer>
    {({ alerts }) => (
      <Container className="position-fixed top-0 start-0 mt-2">
        {alerts?.map(({ id, message }) => (
          <Alert key={id} variant="success">
            {message}
          </Alert>
        ))}
      </Container>
    )}
  </AlertContext.Consumer>
);

export { AlertContextProvider, AlertOutlet };

export default () => {
  const { alerts, setAlerts } = useContext(AlertContext);

  return {
    success: useCallback((message) => {
      setAlerts([...alerts, { message, id: new Date().valueOf() }]);
    }),
  };
};
